package dev.boom.boom_mobile


import android.content.Intent
import android.net.Uri
import androidx.core.content.ContextCompat.startActivity
import androidx.core.net.toUri
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.walletconnect.android.Core
import com.walletconnect.android.CoreClient
import com.walletconnect.sign.client.Sign
import com.walletconnect.sign.client.SignClient
import com.walletconnect.util.bytesToHex
import java.lang.StringBuilder
import java.util.concurrent.TimeUnit
import kotlin.random.Random


class MainViewModel : SignClient.DappDelegate {

    private val _connectionUri = MutableLiveData<String>()

    val connectionUri: LiveData<String> get() = _connectionUri

    private val _address = MutableLiveData<String>()

    val address: LiveData<String?> get() = _address

    private var pairingDeepLink = ""

    private val _goMetamask = MutableLiveData<Boolean>()

    val goMetamask: LiveData<Boolean> get() = _goMetamask

        private var topicApproved=""
            private var account=""

    init {
        SignClient.setDappDelegate(this)
    }

    fun connect() :String{

        SignClient.setDappDelegate(this)
        /* Namespace Identifier */
        val namespace: String = "eip155"

        /* List of chains that the wallet will be requested for */
        val chains: List<String> = listOf(
            //"eip155:42220",// Celo main net
            //"eip155:56",
            //"eip155:1",
            //"eip155:137",
            "eip155:80001",
            //"eip155:97",
        )

        /* List of methods that the wallet will be requested for */

        val methods: List<String> = listOf(
            "eth_sendTransaction", // ATM we only want to sign
            "eth_signTransaction",
            "eth_sign",
            "personal_sign",
        )

        /* List of events that the wallet will be requested for */

        val events: List<String> = listOf(
            "chainChanged",
            "accountChanged"
        )//All possible events

        val expiry =
            (System.currentTimeMillis() / 1000) + TimeUnit.SECONDS.convert(7, TimeUnit.DAYS)
        val properties: Map<String, String> = mapOf("sessionExpiry" to "$expiry")

        val namespaces: Map<String, Sign.Model.Namespace.Proposal> = mapOf(
            namespace to Sign.Model.Namespace.Proposal(
                chains,
                methods,
                events
            )
        )

        val pairing: Core.Model.Pairing = CoreClient.Pairing.create()!!

        val connectParams = Sign.Params.Connect(
            namespaces = namespaces,
            optionalNamespaces = null,
            properties = null,
            pairing = pairing
        )

        SignClient.connect(connectParams,
            onSuccess = {
                println("WALLET_CONN -> SignClient Success")
                var deepLink = pairing.uri
                val replaced = deepLink.replace("wc:", "wc://")
                println("WALLET_CONN -> link: $replaced")
                pairingDeepLink = replaced
//                _connectionUri.postValue(replaced)

            }, onError = { error ->
                println("WALLET_CONN -> SignClient Error $error")

            })
        return pairingDeepLink
    }

    fun signMessage(){
        val params=getPersonalSignBody(account)

        val (parentChain, chainId, account)= account.split(":")
        val requestParams=Sign.Params.Request(
            sessionTopic = requireNotNull(topicApproved),
            method = "eth_SendTransaction",
            params = params,
            chainId= "$parentChain:$chainId"
        )

        val redirect=SignClient.getActiveSessionByTopic(requestParams.sessionTopic)
        println("WALLET_CONN -> active session $redirect")
        SignClient.request(request = requestParams, onSuccess = {it: Sign.Model.SentRequest ->
            println("WALLET_CONN -> Sign request Success $it")

        }, onError = {error ->
            println("WALLET_CONN -> Sign request error $error")
        })

        _connectionUri.postValue(pairingDeepLink)
    }

    fun getPersonalSignBody(account: String): String {
        val msg =
            "My email is rennylngt@gmai.com - ${System.currentTimeMillis()}".encodeToByteArray()
                .joinToString(separator = "", prefix = "0x") { eachByte -> "%02x".format(eachByte) }
        return "[\"$msg\", \"$account\"]"
    }


    override fun onConnectionStateChange(state: Sign.Model.ConnectionState) {
        println("WALLET_CONN -> Sign onConnectionState $state")
    }

    override fun onError(error: Sign.Model.Error) {
        println("WALLET_CONN -> Sign onError $error")
    }

    override fun onSessionApproved(approvedSession: Sign.Model.ApprovedSession) {
        //Triggered when Dapp receives session approval form wallet
        println("WALLET_CONN -> Sign onSessionApproved $approvedSession")
        println("WALLET_CONN -> Details of connected acc ${approvedSession.accounts[0]}")
        topicApproved=approvedSession.topic
        account=approvedSession.accounts[0]
        _address.postValue(account)

    }

    override fun onSessionDelete(deletedSession: Sign.Model.DeletedSession) {
        println("WALLET_CONN -> Sign onSessionDelete $deletedSession")
    }

    override fun onSessionEvent(sessionEvent: Sign.Model.SessionEvent) {
        println("WALLET_CONN -> Sign onSessionEvent $sessionEvent")
    }

    override fun onSessionExtend(session: Sign.Model.Session) {
        println("WALLET_CONN -> Sign onSessionextend $session")
    }

    override fun onSessionRejected(rejectedSession: Sign.Model.RejectedSession) {
        println("WALLET_CONN -> Sign onSessionrejected $rejectedSession")
    }

    override fun onSessionRequestResponse(response: Sign.Model.SessionRequestResponse) {
        println("WALLET_CONN -> Sign onSessionRequest $response")
    }

    override fun onSessionUpdate(updatedSession: Sign.Model.UpdatedSession) {
        println("WALLET_CONN -> Sign onSessionUpdate $updatedSession")
    }

}

fun randomNonce(): String = Random.nextBytes(16).bytesToHex()

fun ByteArray.bytesTohex(): String{
    val hexString = StringBuilder(2*this.size)

    this.indices.forEach{ i ->
        val hex=Integer.toHexString(0xff and this[i].toInt())

        if(hex.length == 1){
            hexString.append('0')
        }

        hexString.append(hex)
    }
    return hexString.toString()
}