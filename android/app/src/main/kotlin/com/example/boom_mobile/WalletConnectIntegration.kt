package com.example.boom_mobile

import android.app.Application
import com.walletconnect.android.Core
import com.walletconnect.android.CoreClient
import com.walletconnect.android.relay.ConnectionType
import com.walletconnect.sign.client.Sign
import com.walletconnect.sign.client.SignClient


class WalletConnectIntegration : Application() {

    override fun onCreate() {
        super.onCreate()
        val projectId = "748a4dd9654a1f5291e7ff9714f63ac7"
        val relayUrl = "relay.walletconnect.com"
        val serverUrl = "wss://$relayUrl?projectId=${projectId}"
        val connectionType = ConnectionType.AUTOMATIC
        val application = this
        println("Wallet_Con -> serverurl $serverUrl")
        val appMetaData = Core.Model.AppMetaData(
            name = "",
            description = "",
            url = "",
            icons = listOf(""),
            redirect = ""

        )

        CoreClient.initialize(
            relayServerUrl = relayUrl,
            connectionType = connectionType,
            application = application,
            metaData = appMetaData
        ) { error ->
            println("Wallet_Con error -> Error initializing core $error")
        }

        SignClient.initialize(init = Sign.Params.Init(core = CoreClient)) { error ->
            println("WalletCon error -> Error Initializing $error")
        }
    }


}