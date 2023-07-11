package dev.boom.boom_mobile

import android.app.PendingIntent.getActivity
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import com.example.boom_mobile.MainFragment
import com.walletconnect.android.Core
import com.walletconnect.android.CoreClient
import com.walletconnect.android.relay.ConnectionType
import com.walletconnect.sign.client.Sign
import com.walletconnect.sign.client.SignClient
import timber.log.Timber

class MainActivity: FlutterActivity() {
    private val CHANNEL="samples.flutter.dev/battery"
    private val WC_CHANNEL="dev.boom.walletConnect/connect"
//    private lateinit var viewModel: MainViewModel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WC_CHANNEL).setMethodCallHandler {
            call,result ->
            if(call.method=="getBatteryLevel"){
                val batterLevel=getBatterLevel()
                if(batterLevel != -1){
                    result.success(batterLevel)
                }else{
                    result.error("UNAVAILABLE","Battery level not available", null)
                }
            }else if(call.method=="connectWallet"){
                println("We are here")
                Timber.i("We have gotten here")
                val walletUri= connectWallet()
                if(walletUri.isNotEmpty()
                ){
                    result.success(walletUri)
                }else{
                   result.error("SIGNERROR","Could not connect wallet",null)
                }

            }

            else{
                result.notImplemented()
            }

        }
    }

    private fun getBatterLevel(): Int{
        val batteryLevel: Int = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP){
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }else{
            val intent= ContextWrapper(applicationContext).registerReceiver(null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)*100/intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }

    //Function to connect Wallet
    private fun connectWallet():String {
        val projectId = "748a4dd9654a1f5291e7ff9714f63ac7"
        val relayUrl = "relay.walletconnect.com"
        val serverUrl = "wss://$relayUrl?projectId=${projectId}"
        val appMetadata= Core.Model.AppMetaData(
            name = "Boom SuperApp",
            description = "Boom social media app",
            url = "https://boooooom.com",
            icons = listOf("https://lh3.googleusercontent.com/pw/AMWts8D1lU-DNAZ4AoaPyHcD8TNiep-EIwPrjfg4NGXLTDdBE3VR3pFoUZmUnfLuzo6lsmsWR-7ireEPwXgwt3G56bDtoVtYVxW7juvw-SN4TolTMHyMT1dEe7JTtuksgJxjxlYOHaZgilElRDWO24P7QL8Xzw=w490-h465-no?authuser=0"),
            redirect = "kotlin-dapp-wc://request"
        )

        CoreClient.initialize(
            relayServerUrl = serverUrl,
            connectionType = ConnectionType.AUTOMATIC,
            application = application,
            metaData = appMetadata,
        ){
            error -> println("Ran into an error -> $error")
        }
        val initParams= Sign.Params.Init(core = CoreClient )

        SignClient.initialize(init = initParams){
            error -> println("An error has occurred -> $error")
        }

        SignClient.setDappDelegate(MainViewModel())

        return MainViewModel().connect() as String

    }

}


