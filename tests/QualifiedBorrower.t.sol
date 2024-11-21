// Copyright 2024 RISC Zero, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.20;

import {RiscZeroCheats} from "risc0/test/RiscZeroCheats.sol";
import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {IRiscZeroVerifier} from "risc0/IRiscZeroVerifier.sol";
import {QualifiedBorrower} from "../contracts/QualifiedBorrower.sol";
import {Elf} from "./Elf.sol"; // auto-generated contract after running `cargo build`.

contract QualifiedBorrowerTest is RiscZeroCheats, Test {
    QualifiedBorrower public qualifiedLender;

    function setUp() public {
        IRiscZeroVerifier verifier = deployRiscZeroVerifier();
        qualifiedLender = new QualifiedBorrower(verifier);
        assertEq(qualifiedLender.get(), 0);
    }

    function test_SetQualified() public {
        uint256 salary = 11000;
        (bytes memory journal, bytes memory seal) = prove(
            Elf.IS_QUALIFIED_PATH,
            abi.encode(salary)
        );

        qualifiedLender.set(abi.decode(journal, (uint256)), seal);
        assertEq(qualifiedLender.get(), salary);
    }

    function test_SetUnqualified() public {
        uint256 salary = 9000;
        (bytes memory journal, bytes memory seal) = prove(
            Elf.IS_QUALIFIED_PATH,
            abi.encode(salary)
        );

        qualifiedLender.set(abi.decode(journal, (uint256)), seal);
        assertEq(qualifiedLender.get(), salary);
    }
}