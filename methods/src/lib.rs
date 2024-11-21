// Copyright 2023 RISC Zero, Inc.
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

//! Generated crate containing the image ID and ELF binary of the build guest.
include!(concat!(env!("OUT_DIR"), "/methods.rs"));

#[cfg(test)]
mod tests {
    use risc0_zkvm::{default_executor, ExecutorEnv};

    #[test]
    fn proves_qualified_borrower() {
        let salary: u32 = 12000;
        let env = ExecutorEnv::builder()
            .write(&salary)
            .unwrap()
            .build()
            .unwrap();

        // NOTE: Use the executor to run tests without proving.
        let _session_info = default_executor()
            .execute(env, super::IS_QUALIFIED_ELF)
            .unwrap();
    }

    #[test]
    #[should_panic(expected = "salary is not above threshold")]
    fn rejects_unqualified_borrower() {
        let salary: u32 = 9000;

        let env = ExecutorEnv::builder()
            .write(&salary)
            .unwrap()
            .build()
            .unwrap();

        // NOTE: Use the executor to run tests without proving.
        let _failed = default_executor()
            .execute(env, super::IS_QUALIFIED_ELF)
            .unwrap();
    }
}
