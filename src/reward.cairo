// use starknet::ContractAddress;


// #[starknet::interface]
// pub trait IReward<TContractState> {
//     fn rewarduser(ref self: TContractState, reward: felt252):
//     fn redemPoint(ref self: TContractState, pointredem: felt252);
//     fn getRewardBalance(self: TContractState) -> felt252;
//     fn get_owner(self: @TContractState) -> ContractAddress;
// }

// #[event]
// #[derive(Drop, starknet::Event)]
// struct RewardEvent {
//     amount: felt252,
// }

// #[starknet::contract]
// mod RewardContract {

//     use starknet::ContractAddress;
//     use starknet::get_caller_address;

//     #[storage]
//     struct Storage {
//         contract_owner: ContractAddress,
//         rewards: felt252,
//     }

//     #[abi(embed_v0)]
//     impl RewardContractImpl of super::IReward<ContractState> {

//         fn rewarduser(ref self: ContractState, amount: felt252, owner: ContractAddress) {
//             assert(amount != 0, 'reward should be greater than 0');
//             self.rewards.write(self.rewards.read() + amount);
//             self.contract_owner.write(owner);
//             self.emit(RewardEvent { amount } );
//         }

//         fn redemPoint(ref self: ContractState, owner: ContractAddress, pointredem: felt252) {
//             assert(self.contract_owner.read() == owner, "Contract address not found");
//             assert(amount != 0, 'Amount cannot be 0');
//             self.rewards.write(self.rewards.read() + pointredem);
//         }

//         fn getRewardBalance(self: @ContractState) -> felt252 {
//             self.rewards.read()
//         } 

//         fn get_owner(self: @ContractState) -> ContractAddress {
//             self.contract_owner.read()
//         }
//     }
// }
