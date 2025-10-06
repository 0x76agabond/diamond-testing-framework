# Diamond Testing via OOP (DTO)

A structured, **OOP-style framework** for testing **Diamond (EIP-2535)** contracts.  
Designed for modularity, clarity, full **test** coverage across facets.

---

## Abstract

**DTO** is a small framework/pattern for testing Diamond contracts.  
It uses isolated runners for complex integration logic by combining:
- Scoped `{}` blocks to keep each run separate  
- `try/catch` to trap expected failures  
- `tPrototype` / `tFacet` contracts as modular test units  

The goal is to provide an elegant way to run large, cross-module test logic inside a single test case — without crashing the whole suite.

## Motivation

When I first researched **EIP-2535 (Diamond Standard)**, the most frustrating thing was how people (and even AI tools like GPT or Gemini) kept calling it *too complicated*.  
OpenZeppelin openly refuses to support it. The meme is always the same: *“just use another proxy.”*

But I see Diamond as a **game-changer for blockchain** — essentially a **microservice system on-chain**.  
Naturally, a complex system needs **integration tests across multiple modules**, which normal frameworks don’t handle gracefully.

With current methods, there’s no clean way to run *massive, cross-facet integration tests*.  
This project shows how an OOP-style test harness can make Diamond testing simpler and more modular.

---

## Note on Gas

Yes, this pattern adds some gas overhead because each `{}` block and `try/catch` introduces extra execution cost.  
But since this is **test logic only**, not production flow, the gas cost doesn’t matter.  
👉 The focus here is **clarity and isolation**, not efficiency.

---

## Facet → Interface → tFacet

A Diamond is infinitely modular — each Facet lives as its own isolated logic block.  
So a monolithic test style (like Foundry’s default `Test.sol` approach) doesn’t scale well here.

The idea is simple:  
👉 **if the system is modular, the test should mirror that modularity.**

- Each **Facet** defines a specific behavior in the Diamond.  
- Each **Interface** describes that behavior’s surface.  
- Each **tFacet** sets up selectors and builds the cut based on its Interface.  
- **tPrototype** represents many **tFacet** just like the **Diamond** represents many **Facets** 

![tPrototype → tFacet → Diamond diagram](https://scontent.fsgn5-9.fna.fbcdn.net/v/t39.30808-6/559113595_3269231586560079_674978664034589222_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEDWQFpwcr3ahVszVrGnouTo9rSqHWHl5yj2tKodYeXnIqp7j3AchPhatdELtGTo_TWqgmVeVapCcoYZFoBicEj&_nc_ohc=6FkXLyTeHuEQ7kNvwGqs80v&_nc_oc=AdnpCvBwBYPKmPSZn1_XvnvInbc-TqcYPYuO3Kj-iZ9uqFkPHn5Kh52muS8cqjVwavU&_nc_zt=23&_nc_ht=scontent.fsgn5-9.fna&_nc_gid=NKh_WN7fQv87NiHBXCVLSQ&oh=00_Affl4IqyC4i_WjCmzkGDgExjdavq95a8lm8TIJqt-uq62Q&oe=68E5DCA8)

---

## Pattern

### 1. `tPrototype`
- Abstract base contract for test units.  
- Holds `selectors[]` and defines `setUp()`, `buildCut()`, `baseCut()`.  

### 2. `tFacet`
- Inherits from `tPrototype`.  
- Declares the real Facet, builds selectors, and implements setup logic.  
- Gets cut into the Diamond, then disposed to free stack space.

### 3. Scoped `{}` Blocks
- Each `{}` represents an isolated sub-test.  
- Keeps state and revert scope clean.  

### 4. `try/catch` Isolation
- Prevents one failed sub-test from stopping the entire run.  
- Each scenario can run independently and log its own results.

---

## Hack

- All `tFacet` contracts were generated from Interfaces using Gemini-CLI.

---

## Note
- **TestAddFacet.t** is a simple unit test for diamond
- **TestMassiveIntegration.t.sol** shows how to use scoped `{}` blocks and `try/catch` to handle large initialization and test flows.  
- **TestSetupDiamond.t.sol** adds an abstraction layer for modular DiamondCuts using the `tPrototype` / `tFacet` pattern.

---

## Requirements
- Foundry 
- Solidity 
- foundry.toml with `rpc_endpoints`

## Getting Started
1. Clone repo  
2. Run `forge install` (if needed)  
3. Add `rpc_endpoints`
4. forge build 
5. forge test TestSetupDiamond.t -vvv
* Since this is a `test framework`, you should check `test` directory for example
---


## Example

### tPrototype

```solidity
abstract contract tPrototype is Test {
    bytes4[] public selectors;

    // @notice Build facet cut struct based on selectors
    // @param facet The facet contract address
    // @return cut as An array containing one FacetCut with all selectors
    function setUp() public virtual;
    function buildCut() external view virtual returns (IDiamondCut.FacetCut[] memory);

    // basically same in all sub contract
    function baseCut(address facet) internal view returns (IDiamondCut.FacetCut[] memory)
    {        
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: facet,
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: selectors
        });

        return cut;
    }
}


```
### tFacet
```solidity
contract tAdd1Facet is tPrototype {
    // for main call
    Add1Facet public facet;

    // set up here
    function setUp() public override {
        // Generate based on Facet
        facet = new Add1Facet();

        // Generate based on Interface
        selectors = new bytes4[](3);
        selectors[0] = IAdd1Facet.whoami1.selector;
        selectors[1] = IAdd1Facet.add1.selector;
        selectors[2] = IAdd1Facet.add1error.selector;
    }

    // basically same in all sub contract
    function buildCut() external override view returns (IDiamondCut.FacetCut[] memory) {
        return baseCut(address(facet));
    }
}
```
### Test Setup

```solidity
// Because all tFacet (tAdd1Facet, tAdd2Facet...) inherit tPrototype we can setup it like this
function cutHelper(tPrototype temp, bytes memory data) internal 
{
    IDiamondCut.FacetCut[] memory cut; 
    temp.setUp();
    cut= temp.buildCut();
    IDiamondCut(address(diamond)).diamondCut(cut, address(diamond), data);
}

function setupDiamond() internal
{
    vm.startPrank(vm.addr(key_owner));

    // Deploy DiamondCutFacet and the main Diamond contract
    {
        DiamondCutFacet cutFacet = new DiamondCutFacet();  
        diamond = new Diamond(address(vm.addr(key_owner)), address(cutFacet));
    }
                
    // start setup here
    {
        // Base utility facets
        cutHelper(new tDiamondLoupe(), "");  

        // Functional modules              
        cutHelper(new tAdd1Facet(), "");   
           
        // Initialization facet (with parameters)
        cutHelper(new tAddFacet(), abi.encodeWithSelector(IAddFacet.init.selector, 500));   
    }

    vm.stopPrank();
}
