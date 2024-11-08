// #[starknet::interface]
// pub trait IHelloStarknet<TContractState> {
//     fn increase_balance(ref self: TContractState, amount: felt252);
//     fn get_balance(self: @TContractState) -> felt252;
// }

// #[starknet::contract]
// mod HelloStarknet {
//     #[storage]
//     struct Storage {
//         balance: felt252, 
//     }

//     #[abi(embed_v0)]
//     impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
//         fn increase_balance(ref self: ContractState, amount: felt252) {
//             assert(amount != 0, 'Amount cannot be 0');
//             self.balance.write(self.balance.read() + amount);
//         }

//         fn get_balance(self: @ContractState) -> felt252 {
//             self.balance.read()
//         }
//     }
// }


use starknet::ContractAddress;


#[starknet::interface]
pub trait IReward<TContractState> {
    fn rewarduser(ref self: TContractState, reward: felt252,  owner: ContractAddress);
    fn redemPoint(ref self: TContractState, owner: ContractAddress, pointredem: felt252);
    fn getRewardBalance(self: @TContractState) -> felt252;
    fn get_owner(self: @TContractState) -> ContractAddress;
}



#[starknet::contract]
mod RewardContract {

    use starknet::ContractAddress;
    // use starknet::get_caller_address;

    #[storage]
    struct Storage {
        contract_owner: ContractAddress,
        rewards: felt252,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        RewardEvent: RewardEvent,
        RedemPoint: RedemPoint,
    }

    #[derive(Drop, starknet::Event)]
    pub struct RewardEvent {
        pub reward: felt252,
    }
    
    #[derive(Drop, starknet::Event)]
    pub struct RedemPoint {
        pub pointredem: felt252,
    }

    #[abi(embed_v0)]
    impl RewardContractImpl of super::IReward<ContractState> {
        
        fn rewarduser(ref self: ContractState, reward: felt252, owner: ContractAddress) {
            assert(reward != 0, 'reward should be greater than 0');
            self.rewards.write(self.rewards.read() + reward);
            self.contract_owner.write(owner);
            self.emit( RewardEvent { reward } );
        }

        fn redemPoint(ref self: ContractState, owner: ContractAddress, pointredem: felt252) {
            assert(self.contract_owner.read() == owner, 'Contract address not found');
            assert(pointredem != 0, 'Amount cannot be 0');
            self.rewards.write(self.rewards.read() + pointredem);
            self.emit( RedemPoint { pointredem })
        }

        fn getRewardBalance(self: @ContractState) -> felt252 {
            self.rewards.read()
        } 

        fn get_owner(self: @ContractState) -> ContractAddress {
            self.contract_owner.read()
        }
    }
}
