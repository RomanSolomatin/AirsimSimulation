#pragma once

#ifndef _Thread_H
#define _Thread_H

#include "stdio.h"  
#include "iostream"  
//#include "NeuralNet/DataPackage/DataPackage.h"
#include "NeuralNet/DataPackage/DataPack.h"
#include "NeuralNet/Udp/Udp.h"
namespace msr {
	namespace airlib {

		DWORD WINAPI ThreadReceive(LPVOID lpParam);

		//���ݰ���ʼ��
		extern DataPack dataPack;

		//UDP��ʼ��
		extern UdpSever udpSever;
	}
}
#endif






