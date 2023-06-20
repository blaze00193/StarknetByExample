#[abi]
trait IMapContract {
    #[external]
    fn set(key: starknet::ContractAddress, value: felt252);
    #[view]
    fn get(key: starknet::ContractAddress) -> felt252;
}

#[cfg(test)]
mod tests {
    use maps::mappings::MapContract;
    use super::{IMapContractDispatcher, IMapContractDispatcherTrait};
    use debug::PrintTrait;
    use starknet::{deploy_syscall, ContractAddress};
    use option::OptionTrait;
    use array::ArrayTrait;
    use traits::{Into, TryInto};
    use starknet::class_hash::Felt252TryIntoClassHash;
    use result::ResultTrait;

    #[test]
    #[available_gas(2000000000)]
    fn test_set_get() {
        // Set up.
        let mut calldata: Array<felt252> = ArrayTrait::new();
        let (address0, _) = deploy_syscall(
            MapContract::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
            .unwrap();
        let mut contract = IMapContractDispatcher { contract_address: address0 };

        // Write to map.
        let value: felt252 = 1;
        let contract_address: ContractAddress = address0;

        contract.set(key: contract_address, value: value);

        // Read from map.
        let read_value = contract.get(contract_address);
        assert(read_value == 1, 'wrong value read');
    }
}

