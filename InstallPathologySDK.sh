#!/bin/sh
set -e
PYTHON3_VERSION="py3"
ACCEPT=$2
INPUT_PYTHON_VERSION=$1

if [ "$INPUT_PYTHON_VERSION" = "" ];then
        echo "$(tput setaf 1)Python argument Not given$(tput sgr 0)"
        exit
fi

agreement() {
echo "$(tput setaf 3)By installing this software, you agree to the End User License Agreement for Research Use.$(tput sgr 0)"
echo "$(tput setaf 3)Type 'y' to accept.$(tput sgr 0)"
read -p "Enter your response:"  ACCEPT_AGREEMENT
}

installSdk() {
apt-get install -y gdebi
if [ "$PYTHON3_VERSION" = "$INPUT_PYTHON_VERSION" ];then
        echo "$(tput setaf 2)Installing PathologySDK2.0 modules please wait... $(tput sgr 0)"
        gdebi -n ./pathologysdk-modules/*pixelengine*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-pixelengine*.deb
		gdebi -n ./pathologysdk-modules/*eglrendercontext*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-eglrendercontext*.deb
		gdebi -n ./pathologysdk-modules/*gles2renderbackend*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-gles2renderbackend*.deb
		gdebi -n ./pathologysdk-modules/*gles3renderbackend*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-gles3renderbackend*.deb
		gdebi -n ./pathologysdk-modules/*softwarerenderer*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-softwarerenderbackend*.deb
		gdebi -n ./pathologysdk-python36-modules/*python3-softwarerendercontext*.deb
        echo "$(tput setaf 2)PathologySDK2.0 successfully installed$(tput sgr 0)"

else
        echo "$(tput setaf 1)Selected python version is NOT supported.$(tput sgr 0)"
        exit 0

fi

}

if [ "$ACCEPT" = "-y" ]; then
	echo "$(tput setaf 2)Accepted end user license agreement.$(tput sgr 0)"
	installSdk
	exit 0
elif [ "$ACCEPT" = "" ];then
	agreement
	if [ "$ACCEPT_AGREEMENT" = "y" ]; then
		installSdk
		exit 0
	else
		echo "$(tput setaf 1)Exiting installation. Please accept the end user license agreement to install the SDK.$(tput sgr 0)"
		exit 0
	fi
else
	echo "$(tput setaf 1)Exiting installation. Please accept the end user license agreement to install the SDK.$(tput sgr 0)"
	exit 0
fi
