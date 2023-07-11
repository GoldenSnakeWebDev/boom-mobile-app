package com.example.boom_mobile

import android.content.Intent
import android.os.Bundle
import androidx.core.net.toUri
import androidx.fragment.app.Fragment

import androidx.lifecycle.ViewModelProvider
import dev.boom.boom_mobile.MainViewModel


class MainFragment: Fragment() {

    companion object{
        fun newInstance()=MainFragment()
    }

    private lateinit var viewModel: MainViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        viewModel=ViewModelProvider(this).get(MainViewModel::class.java)
        setListeners()
        connectWallet()
    }


    private fun connectWallet(){
        viewModel.connect()

    }

    private fun setListeners(){

        viewModel.connectionUri.observe(viewLifecycleOwner){ uri ->

            println("The URI is -> ${uri.toUri()}")
            try{
                requireActivity().startActivity(Intent(Intent.ACTION_VIEW, uri.toUri()))
            }catch (e: Exception){
                println("WALLET_CONN -> no app compatible")
            }

        }

    }
}