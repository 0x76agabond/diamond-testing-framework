//test/Light_Diamond.t.t.sol
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {IDiamondCut} from "../src/interfaces/IDiamondCut.sol";

import {DiamondCutFacet} from "../src/facets/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "../src/facets/DiamondLoupeFacet.sol";

import {Enum} from "../src/libraries/Enum.sol";

import {tPrototype} from "./tContract/tPrototype.sol";
import {tGuard, IGuard} from "./tContract/tGuard.sol";
import {tTransfer, ITransfer} from "./tContract/tTransfer.sol";
import {tAllowance, IAllowance} from "./tContract/tAllowance.sol";
import {tLoupe, IDiamondLoupe} from "./tContract/tDiamondLoupe.sol";
import {tAdminManager, IAdminManager} from "./tContract/tAdminManager.sol";

import {NotSafe} from "../src/NotSafe.sol";
import {Diamond} from "../src/Diamond.sol";
import {IBEP20, BEP20Token} from "../src/ERC20.sol";


////-----------------------------------------------------------------
////  Light Diamond
////-------------------------------
////  Test Framework for FVSF
////  home make test framework for test complicated project (currently optimize for diamond base)
////  todo: need a tool to auto generate tContract
////-------------------------------

contract LightDiamondTest is Test {

    Diamond diamond;
    DiamondCutFacet cutFacet;    

    uint256 key_customer;
    uint256 key_admin;
    uint256 key_manager;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("opbnb"));

        key_customer = vm.envUint("CUSTOMER_KEY");
        key_admin = vm.envUint("ADMIN_KEY");
        key_manager  = vm.envUint("PRIVATE_KEY");
    }

    function test_LightDiamond_Guard() public {            

        // Diamond init
        
        vm.startPrank(vm.addr(key_manager));
        cutFacet = new DiamondCutFacet();
        diamond = new Diamond(address(vm.addr(key_manager)), address(cutFacet));

        // Cut

        tPrototype temp;
        IDiamondCut.FacetCut[] memory cut; 
        {
            temp = new tAdminManager();
            temp.setUp();
            cut= temp.buildCut();
            IDiamondCut(address(diamond)).diamondCut(cut, address(diamond), abi.encodeWithSelector(IAdminManager.initAdmin.selector));
        }
        {
            temp = new tTransfer();
            temp.setUp();
            cut= temp.buildCut();
            IDiamondCut(address(diamond)).diamondCut(cut, address(diamond), abi.encodeWithSelector(ITransfer.initTransfer.selector));
        }
        {
            temp = new tAllowance();
            temp.setUp();
            cut= temp.buildCut();
            IDiamondCut(address(diamond)).diamondCut(cut, address(diamond), abi.encodeWithSelector(IAllowance.initAllowance.selector));
        }
        {
            temp = new tLoupe();
            temp.setUp();
            cut= temp.buildCut();
            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
        {
            temp = new tGuard();
            temp.setUp();
            cut= temp.buildCut();
            IDiamondCut(address(diamond)).diamondCut(cut, address(0), "");
        }
       
        // Test from here
        // Due to Stupidity of Solidity every test case should wrap in a {} block

        // Gnosis + ERC20 + Diamond
        {   
            console.log("Diamond", address(diamond));

            // ACTIVE GUARD       
            IAdminManager(address(diamond)).changeState(); 
            console.log("isActive", IAdminManager(address(diamond)).isActive());

            //SETUP
            NotSafe notSafe = new NotSafe();
            BEP20Token token = new BEP20Token();

            token.transfer(address(notSafe), 10000000000000000000);
            console.log("Balance of wallet: ", token.balanceOf(address(notSafe)));
            
            //ADD TOKEN 
            ITransfer(address(diamond)).addToken(address(token)); 
            uint256 decimal = ITransfer(address(diamond)).getSupportedTokenDecimal(address(token));
            console.log("check add token", decimal);

            //ADD GUARD
            notSafe.setGuard(address(diamond));
            console.log("wallet", address(notSafe));
            console.log("wallet guard", address(notSafe.getGuard()));

            //ADD WALLET PERMISSION
            IAllowance(address(diamond)).setAllowance(
                address(notSafe),
                5,
                1000000000000000000
            );

            {
                (
                    ,//uint256 nonce,
                    ,//uint256 last_amount,
                    ,//address last_token,
                    uint256 daily_counter,
                    uint256 daily_amount,
                    bool is_allowed
                ) = IAllowance(address(diamond)).getWallet(address(notSafe));

                console.log("getWallet:",          
                    daily_counter,
                    daily_amount,
                    is_allowed
                );
            }                    

            {   
                (
                    uint256 counter,
                    uint256 amount,            
                    uint256 lastsend
                ) = IAllowance(address(diamond)).getAllowance(address(notSafe), address(token));

                console.log("getAllowance:",          
                    counter,
                    amount,
                    lastsend
                );
            }

            //Get Max Amount on Transfer Inbound
            console.log("Transfer Inbound",
            ITransfer(address(diamond)).getMaxTransfer(
                Enum.TransferType.Inbound,
                address(notSafe), 
                address(token),
                decimal
                ));

            //Get Max Amount on Transfer Outbound
            console.log("Transfer Outbound",
            ITransfer(address(diamond)).getMaxTransfer(
                Enum.TransferType.Outbound,
                address(notSafe), 
                address(token),
                decimal
                ));
                
            // Get Max Allowance
            console.log("Allowance",
            IAllowance(address(diamond)).getMaxAllowance(
                address(notSafe), 
                address(token),
                decimal
                ));
            
            // Set Manager lim - 0.08
            IAllowance(address(diamond)).setManagerLim(80000000000000000);

            // Set Daily lim - 0.25
            IAllowance(address(diamond)).setDailyLim(250000000000000000);

            // Get Manager lim
            console.log("Manager lim",
            IAllowance(address(diamond)).getManagerLimit());

            // Get Daily lim
            console.log("Daily lim",
            IAllowance(address(diamond)).getDailyLimit());

            //Get Max Amount on Guard
            console.log("getGuardTransfer Inbound", 
            IGuard(address(diamond)).getGuardTransfer(
                address(notSafe),
                address(token),
                Enum.TransferType.Inbound
                ));

            //get Guard
            console.log("getGuardTransfer Outbound", 
            IGuard(address(diamond)).getGuardTransfer(
                 address(notSafe),
                 address(token),
                 Enum.TransferType.Outbound
                 ));
            
            // Add TransAdmin
            IAdminManager(address(diamond)).addTransAdmin(address(vm.addr(key_admin)));
            console.log("check admin init",
                IAdminManager(address(diamond)).isTransAdmin(address(vm.addr(key_admin))));                 

            vm.stopPrank();

            {

                // test process here

                /*

                    Balance of wallet  10000000000000000000       //10
                    Allowance 1000000000000000000                 //1
                    Transfer Inbound 100000000000000000           //0.1
                    Transfer Outbound 100000000000000000          //0.1             
                    getGuardTransfer Inbound 100000000000000000   //0.1
                    getGuardTransfer Outbound 100000000000000000  //0.1

                */
                uint256 ctime = block.timestamp;                            
                bytes memory signature = hex"0000000000000000000000000ab6bddcf86af6a39d02140f77028a07c145b3bf0000000000000000000000000000000000000000000000000000000000000000010189ea21321b15e1471193e3d5fb96066f438205d43420d87dc1857e210382eb2b37ee9c15592ebbb9f60ddb3bf876fbff3d700feaf78782a8b2b10d86d162bc1b";

                address recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                uint256 amount = 1100000000000000000; 
                bytes memory data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );

                console.log("admin:", address(vm.addr(key_admin)) );
                console.log(" ======================================================== ");

                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 71999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );

                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 72999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 73999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

               console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 74999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 75999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 30999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 3; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 1;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                console.log(" ======================================================== ");
                recipient = 0x4972c533dA7ad4f444d25556521862Ef8b08e9BA;
                amount = 71999999999999999; 
                data = abi.encodeWithSelector(
                    bytes4(keccak256("transfer(address,uint256)")),
                    recipient,
                    amount
                );
                
                ctime += 86300;
                vm.warp(ctime);    
                vm.prank(address(vm.addr(key_customer)));
                try notSafe.execTransaction(address(token), data, payable(address(0)), signature)
                {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("pass");
                }   
                catch Error(string memory reason) {
                    console.log("notSafe.execTransaction");
                    console.log(amount);
                    console.log("fail");
                    console.log(reason);
                }

                {
                    console.log(" ======================================================== ");
                    (
                        ,//uint256 nonce,
                        ,//uint256 last_amount,
                        ,//address last_token,
                        uint256 daily_counter,
                        uint256 daily_amount,
                        bool is_allowed
                    ) = IAllowance(address(diamond)).getWallet(address(notSafe));

                    console.log("getWallet:",          
                        daily_counter,
                        daily_amount,
                        is_allowed
                    );
                }                    

                {   
                    console.log(" ======================================================== ");
                    (
                        uint256 counter,
                        uint256 amountz,            
                        uint256 lastsend
                    ) = IAllowance(address(diamond)).getAllowance(address(notSafe), address(token));

                    console.log("getAllowance:",          
                        counter,
                        amountz,
                        lastsend
                    );
                }
            }
        }
    }
}


