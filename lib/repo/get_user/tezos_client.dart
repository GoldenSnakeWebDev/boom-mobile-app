import 'package:tezart/tezart.dart';

class TezosClient {
  callTezos() async {
    enableTezartLogger();
    // var source = Keystore.random();
    final contract = Contract(
      contractAddress: 'KT1PRWAcEAU6Y5P23zGqHEwsBPy5JiuZ1Cq6',
      rpcInterface: RpcInterface('https://rpc.tzkt.io/ghostnet'),
    );
    // ignore: todo
    // TODO: Explore contract entrypoints here ==> https://ghostnet.tzkt.io/KT1PRWAcEAU6Y5P23zGqHEwsBPy5JiuZ1Cq6

    // final callContractOperationMint = await contract.callOperation(
    //   entrypoint: 'mint',
    //   params: [
    // {
    // "amount": 1,
    // "to_": "tz1PRWAcEAU6Y5P23zGqHEwsBPy5
    // },
    // ],
    //   source: source,
    // );

    // final callContractOperationCreateListing = await contract.callOperation(
    //   entrypoint: 'createListing',
    //   params: {
    // "asset_contract": ""
    // },
    //   source: source,
    // );

    await contract.storage;
    // await callContractOperationsList.executeAndMonitor();
  }
}
