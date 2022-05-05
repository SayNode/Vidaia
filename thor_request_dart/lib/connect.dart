import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:thor_devkit_dart/crypto/blake2b.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';
import 'package:thor_devkit_dart/transaction.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_devkit_dart/types/clause.dart' as dev;
import 'package:thor_request_dart/clause.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/utils.dart';
import 'package:thor_request_dart/wallet.dart';
const String vthoAbi = """
{
    "abi": [
        {
            "constant": true,
            "inputs": [],
            "name": "name",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "pure",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_spender",
                    "type": "address"
                },
                {
                    "name": "_value",
                    "type": "uint256"
                }
            ],
            "name": "approve",
            "outputs": [
                {
                    "name": "success",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_from",
                    "type": "address"
                },
                {
                    "name": "_to",
                    "type": "address"
                },
                {
                    "name": "_amount",
                    "type": "uint256"
                }
            ],
            "name": "transferFrom",
            "outputs": [
                {
                    "name": "success",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "decimals",
            "outputs": [
                {
                    "name": "",
                    "type": "uint8"
                }
            ],
            "payable": false,
            "stateMutability": "pure",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_owner",
                    "type": "address"
                }
            ],
            "name": "balanceOf",
            "outputs": [
                {
                    "name": "balance",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "symbol",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "pure",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_to",
                    "type": "address"
                },
                {
                    "name": "_amount",
                    "type": "uint256"
                }
            ],
            "name": "transfer",
            "outputs": [
                {
                    "name": "success",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_from",
                    "type": "address"
                },
                {
                    "name": "_to",
                    "type": "address"
                },
                {
                    "name": "_amount",
                    "type": "uint256"
                }
            ],
            "name": "move",
            "outputs": [
                {
                    "name": "success",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "totalBurned",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_owner",
                    "type": "address"
                },
                {
                    "name": "_spender",
                    "type": "address"
                }
            ],
            "name": "allowance",
            "outputs": [
                {
                    "name": "remaining",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "name": "_from",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "name": "_to",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "_value",
                    "type": "uint256"
                }
            ],
            "name": "Transfer",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "name": "_owner",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "name": "_spender",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "_value",
                    "type": "uint256"
                }
            ],
            "name": "Approval",
            "type": "event"
        }
    ]
}
""";

///Connect to VeChain
class Connect {
  //url of the VeChain node
  late String url;

  Connect(this.url);

  ///Takes a address [address] and returns te account status as a json
  Future<Map> getAccount(String address, {String block = 'best'}) async {
    var headers = {
      'accept': 'application/json',
    };

    var params = {
      'revision':
          '0x003dc697f70205861a70fd3e52a24a542613b564bf6d8b7b4149c6b3ee6e015d',
    };
    //var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var u = Uri.parse('$url/accounts/$address?revision=$block');
    var res = await http.get(u, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    Map map = jsonDecode(res.body);
    return map;
  }

  ///returns VET blance in VEI
  Future<BigInt> getVetBalance(String address) async {
    Map map = await getAccount(address);
    String b = map['balance'];
    BigInt balance = BigInt.parse(b.substring(2), radix: 16);
    return balance;
  }

  ///returns the VTHO balance in Wei
  Future<BigInt> getVthoBalance(String address) async {
    Map map = await getAccount(address);
    String b = map['energy'];
    BigInt balance = BigInt.parse(b.substring(2), radix: 16);
    return balance;
  }

  ///[block] enter block id or number, [expanded] returned block data should be expanded
  Future<Map> getBlock({String block = 'best', bool expanded = false}) async {
    var headers = {
      'accept': 'application/json',
    };

    String e;
    if (expanded == true) {
      e = 'true';
    } else {
      e = 'false';
    }
    var u = Uri.parse('$url/blocks/$block?expanded=$e');
    var res = await http.get(u, headers: headers);
    Map map = jsonDecode(res.body);
    return map;
  }

  ///returns chaintag
  Future<int> getChainTag() async {
    var block = await getBlock(block: '0');
    String p = block['id'];
    return int.parse(p.substring(p.length - 2), radix: 16);
  }

  ///get transaction data of trnsaction with id [transactionId]
  Future<Map> getTransaction(String transactionId) async {
    var headers = {
      'accept': 'application/json',
    };
    var u = Uri.parse('$url/transactions/$transactionId');
    var res = await http.get(u, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
    Map output = jsonDecode(res.body);
    return output;
  }

  ///post a new transaction with raw payload [raw]
  Future<Map> postTransaction(String raw) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var data = '{"raw":"$raw"}';
    var u = Uri.parse('$url/transactions');
    var res = await http.post(u, headers: headers, body: data);
    if (res.statusCode != 200) {
      var r = res.body;
      throw Exception('http.post error: statusCode= ${res.statusCode}, $r');
    }
    return json.decode(res.body);
  }

  ///get transaction recipt of transaction with id [transactionId]
  Future<Map?> getTransactionReceipt(String transactionId) async {
    var headers = {
      'accept': 'application/json',
    };
    var u = Uri.parse('$url/transactions/$transactionId/receipt');
    var res = await http.get(u, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
    Map output = jsonDecode(res.body);
    return output;
  }

  ///   Wait for tx receipt, for several seconds
  ///   Returns the receipt or Null
  Future<Map?> waitForTxReceipt(String txId, {int timeout = 20}) async {
    int rounds = timeout; //how many attempts
    Map? receipt;
    for (var i = 0; i < rounds; i++) {
      receipt = await getTransactionReceipt(txId);
      if (receipt != null) {
        return receipt;
      } else {
        sleep(const Duration(seconds: 3)); // interval
      }
    }

    return null;
  }

  ///stream output of best block
  Stream<Map> ticker() async* {
    //var i = 1;
    Map oldBlock = await getBlock();
    while (true) {
      Map newBlock = await getBlock();
      if (newBlock['id'] != oldBlock['id']) {
        oldBlock = newBlock;
        yield newBlock;
      } else {
        sleep(const Duration(seconds: 1));
      }
    }
  }

  ///   Upload a tx body for emulation,
  ///   Get a list of execution responses (as the tx has multiple clauses).
  Future<List<Map>> emulate(Map body, {String block = 'best'}) async {
    var u = Uri.parse('$url/accounts/*?revision=$block');
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    var res = await http.post(u, headers: headers, body: json.encode(body));
    if (res.statusCode != 200) {
      var r = res.body;
      throw Exception("HTTP error: ${res.statusCode} ${res.reasonPhrase}, $r");
    }
    Map allResponses = json.decode(res.body)[0]; // A list of responses

    return [injectRevertReason(allResponses)];
  }

  ///  Use the emulate function to replay the tx softly (for debug)
  ///  Usually when you replay the tx to see what's wrong.
  Future<List<Map>> replayTx(String txId) async {
    Map tx = await getTransaction(txId);
    var caller = tx["origin"];
    var targetBlock = tx["meta"]["blockID"];
    var emulateBody = calcEmulateTxBody(caller, tx);
    if (tx["delegator"] != null) {
      emulateBody["gasPayer"] = tx["delegator"];
    }

    return emulate(emulateBody, block: targetBlock);
  }

  ///Emulate the execution of a transaction.[adress] address of caller, [txBody] Tx body to be emulated, [block] Target at which block? by default "best",
  Future<List<Map>> emulateTx(String address, Map txBody,
      {String block = "best", String? gasPayer}) {
    Map emulate_body = calcEmulateTxBody(address, txBody, gaspayer: gasPayer);
    return emulate(emulate_body, block: block);
  }

//TODO: is this really needed? remove if not
  ///There are two types of calls:
  ///1) Function call on a smart contract
  /// Build a clause according to the function name and params.
  /// raise Exception when function is not found by name.
  ///2) Pure transfer of VET
  ///Set the contract, func_name, and funcParams to None
  ///Parameters
  ///----------
  ///contract : Contract
  /// On which contract the function is sitting.
  ///func_name : str
  ///Name of the function.
  ///funcParams : List
  ///Function params supplied by users.
  ///to : str
  ///Address of the contract.
  ///value : int, optional
  ///VET sent with the clause in Wei, by default 0
  Clause clause(Contract contract, String func_name, List funcParams, String to,
      {BigInt? value}) {
    value ??= BigInt.zero;
    return Clause(to,
        contract: contract,
        functionName: func_name,
        functionParameters: funcParams,
        value: value);
  }

  ///Call a contract method (read-only).
  ///This is a single transaction, single clause call.
  ///This WON'T create ANY change on blockchain.
  ///Only emulation happens.
  ///If function has any return value, it will be included in "decoded" field

  Future<Map> call(String caller, Contract contract, String func_name,
      List funcParams, String to,
      {BigInt? value,
      int gas = 0, // Note: value is in Wei
      String? gasPayer, // Note: gas payer of the tx
      String block = "best" // Target at which block
      }) async {
    // Get the Clause object
    var clause = this.clause(contract, func_name, funcParams, to, value: value);
    // Build tx body
    var needFeeDelegation = gasPayer != null;

    Map b = await getBlock();
    Map txBody = buildTxBody([clause.clause], await getChainTag(),
        calc_blockRef(b["id"]), calc_nonce(),
        gas: gas, feeDelegation: needFeeDelegation);

    // Emulate the Tx
    List eResponses = await emulateTx(caller, txBody,
        block: block, gasPayer: gasPayer = gasPayer);
    // Should only have one response, since we only have 1 clause
    assert(eResponses.length == 1);

    // If emulation failed just return the failed response.
    if (any_emulate_failed(eResponses)) {
      return eResponses[0];
    }

    return _beautify(eResponses[0], clause.contract!, clause.functionName!);
  }

  ///Call a contract method (read-only).
  ///This is a single transaction, multi-clause call.
  ///This WON'T create ANY change on blockchain.
  ///Only emulation happens.
  ///If the called functions has any return value, it will be included in "decoded" field
  Future<List<Map>> call_multi(String caller, List<Clause> clauses,
      {int gas = 0, String? gasPayer, String block = "best"}) async {
    bool needFeeDelegation = gasPayer != null;
    // Build tx body
    List<String> tempClauses = [];
    for (var clause in clauses) {
      tempClauses.add(json.encode(clause.clause));
    }
    Map b = await getBlock();
    var txBody = buildTxBody([json.encode(tempClauses)], await getChainTag(),
        calc_blockRef(b["id"]), calc_nonce(),
        gas: gas, feeDelegation: needFeeDelegation);

    // Emulate the Tx
    var eResponses =
        await emulateTx(caller, txBody, block: block, gasPayer: gasPayer);
    assert(eResponses.length == clauses.length);

/*
        // Try to beautify the responses
        List _responses = [];
        for response, clause in zip(eResponses, clauses):
            // Failed response just ouput plain response
            if is_emulate_failed(response):
                _responses.append(response)
                continue
            // Success response inject beautified decoded data
            _responses.append(
                _beautify(response, clause.get_contract(), clause.get_func_name()))
*/
    return eResponses;
  }

  Future<Map> transact(Wallet wallet, Contract contract, String func_name,
      List funcParams, String to,
      {BigInt? value, // Note: value is in Wei
      int expiration = 32,
      int gasPriceCoef = 0,
      int gas = 0,
      String? dependsOn, // ID of old Tx that this tx depends on, None or string
      bool force = false, // Force execute even if emulation failed
      Wallet? gasPayer // fee delegation feature
      }) async {
    value ??= BigInt.zero;
    Clause clause =
        this.clause(contract, func_name, funcParams, to, value: value);
    var needFeeDelegation = gasPayer != null;
    var b = await getBlock();
    var txBody = buildTransaction([clause.getDevClause()], await getChainTag(),
        calc_blockRef(b["id"]), calc_nonce(),
        gasPriceCoef: gasPriceCoef,
        dependsOn: dependsOn = dependsOn,
        expiration: expiration,
        gas: gas,
        feeDelegation: needFeeDelegation);

    List<Map> eResponses;
    // Emulate the tx first.
    if (!needFeeDelegation) {
      eResponses =
          await emulateTx(wallet.adressString, json.decode(txBody.toJsonString()));
    } else {
      eResponses = await emulateTx(
          wallet.adressString, json.decode(txBody.toJsonString()),
          gasPayer: gasPayer.adressString);
    }

    if (any_emulate_failed(eResponses) && force == false) {
      throw Exception("Tx will revert: $eResponses");
    }

    // Get gas estimation from remote node
    // Calculate a safe gas for user
    var vmGas = read_vm_gases(await eResponses).sum;
    print(vmGas);
    var safeGas = suggest_gas_for_tx(vmGas, json.decode(txBody.toJsonString()));
    if (gas < safeGas) {
      if (gas != 0 && force == false) {
        throw Exception("gas $gas < emulated gas $safeGas");
      }
    }

    // Fill out the gas for user
    if (gas == 0) {
      print(safeGas);
      txBody.gas.big = BigInt.from(safeGas);
    }

    // Post it to the remote node
    /*
    var encodedRaw;
    if (!needFeeDelegation) {
      encodedRaw = 
      encodedRaw = calcTxSignedEncoded(wallet, json.decode(txBody.toJsonString()));
    } else {
      encodedRaw = calc_tx_signed_with_fee_delegation(wallet, gasPayer, json.decode(txBody.toJsonString()));
    }
    */
    Uint8List h = blake2b256([txBody.encode()]);
    Uint8List sig = sign(h, wallet.priv).serialize();
    txBody.signature = sig;
    String raw = '0x' + bytesToHex(txBody.encode());

    return postTransaction(raw);
  }

  transactMulti(Wallet wallet, List<Clause> clauses,
      {int gasPriceCoef = 0,
      int gas = 0,
      String? dependsOn,
      int expiration = 32,
      bool force = false,
      Wallet? gasPayer}) async {
    //Emulate transaction first
    List eResponses;
    if (gasPayer != null) {
      eResponses = await call_multi(wallet.adressString, clauses,
          gas: gas, gasPayer: gasPayer.adressString);
    } else {
      eResponses = await call_multi(wallet.adressString, clauses, gas: gas);
    }

    if (any_emulate_failed(eResponses)) {
      throw Exception('Transaction will revert $eResponses');
    }

    bool needFeeDelegation = gasPayer != null;
    //parse clauses
    List<String> mapClauses = [];
    for (var clause in clauses) {
      mapClauses.add(json.encode(clause.clause));
    }
    int chainTag = await getChainTag();
    var b = await getBlock();
    //Build body
    var txBody = buildTxBody(mapClauses, chainTag, b['id'], calc_nonce(),
        expiration: expiration,
        gas: gas,
        gasPriceCoef: gasPriceCoef,
        feeDelegation: needFeeDelegation);
    //GEt gas estimation for remote node
    //Calculate  gas safe for user
    var vmGas = read_vm_gases(eResponses).sum;
    var safeGas = suggest_gas_for_tx(vmGas, txBody);
    if (gas < safeGas) {
      if (!force) {
        throw Exception('gas $gas < emulated gas $safeGas');
      }
    }

//post to remote node
    var encodedRaw;
    if (!needFeeDelegation) {
      encodedRaw = calcTxSignedEncoded(wallet, txBody);
    } else {
      encodedRaw = calc_tx_signed_with_fee_delegation(wallet, gasPayer, txBody);
    }
    return postTransaction(encodedRaw);
  }

  ///Deploy a smart contract to blockchain
  ///This is a single clause transaction.
  Future<Map> deploy(Wallet wallet, Contract contract, List<String> paramsTypes,
      List params, BigInt value) async {
//build transaction body
    var dataBytes;
    if (paramsTypes.isEmpty) {
      dataBytes = contract.getBytecode();
    } else {
      dataBytes = contract.getBytecode() + buildParams(paramsTypes, params);
    }
    var data = "0x" + bytesToHex(dataBytes);
    var b = await getBlock();
    Map clause = {"to": null, "value": value, "data": data};
    var txBody = buildTxBody(
      [json.encode(clause)],
      await getChainTag(),
      calc_blockRef(b["id"]),
      calc_nonce(),
      gas: 0, // We will estimate the gas later
    );

    // We emulate it first.
    var eResponses = await emulateTx(wallet.adressString, txBody);
    if (any_emulate_failed(eResponses)) {
      throw Exception("Tx will revert: $eResponses");
    }

    // Get gas estimation from remote
    var vmGas = read_vm_gases(eResponses).sum;
    var safeGas = suggest_gas_for_tx(vmGas, txBody);

    // Fill out the gas for user.
    txBody["gas"] = safeGas;

    var encodedRaw = calcTxSignedEncoded(wallet, txBody);
    return postTransaction(encodedRaw);
  }

  ///Convenient function: do a pure VET transfer
  ///Parameters: to :  Address of the receiver, value : optional Amount of VET to transfer in Wei, by default 0
  Future<Map> transferVet(Wallet wallet, String to,
      {BigInt? value, Wallet? gasPayer}) async {
    value ??= BigInt.zero;
    var clause = dev.Clause(to, value.toRadixString(10), '0x');
    Clause(to, value: value);
    var b = await getBlock();
    //TODO: emulate gas?
    var gas = 21000;
    var tx = buildTransaction(
        [clause], await getChainTag(), calc_blockRef(b["id"]), calc_nonce(),
        gas: gas);

    Uint8List h = blake2b256([tx.encode()]);
    Uint8List sig = sign(h, wallet.priv).serialize();
    tx.signature = sig;
    String raw = '0x' + bytesToHex(tx.encode());
    return postTransaction(raw);
  }

  Future<Map> transferVtho(Wallet wallet, String to,
      [BigInt? vthoInWei, Wallet? gasPayer]) {
    vthoInWei ??= BigInt.zero;
    const vthoAdress = '0x0000000000000000000000000000456E65726779';
    Contract contract = Contract.fromJsonString(vthoAbi);
    return transact(wallet, contract, 'transfer', [to, vthoInWei], vthoAdress,
        gasPayer: gasPayer);
  }

  Future<Map> transferToken(
      Wallet wallet, String to, String tokenContractAddress,
      [BigInt? amountInWei, Wallet? gasPayer]) {
    amountInWei ??= BigInt.zero;
    Contract contract = Contract.fromJsonString(vthoAbi);
    return transact(
        wallet, contract, 'transfer', [to, amountInWei], tokenContractAddress,
        gasPayer: gasPayer);
  }
}

///Beautify a emulation response dict, to include decoded return and decoded events
Map _beautify(Map response, Contract contract, String func_name) {
  //Decode return value
  response = inject_decoded_return(response, contract, func_name);
  //Decode events (if any)
  if (response["events"].isEmpty) {
    return response;
  }

  response["events"] = [
    //FIXME:dont think this will work in dart, fix if it doesnt
    for (var item in response["events"]) {inject_decoded_event(item, contract)}
  ];

  return response;
}
