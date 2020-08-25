pipeline{
    agent any
    options {
        ansiColor('xterm')
    }
    stages{
        stage ('run script'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'vsphereMaikWaigant', usernameVariable: 'VI_USERNAME', passwordVariable: 'VI_PASSWORD')]) {
                  sh """
                    podman run --rm -it --entrypoint="/usr/bin/pwsh" \
                    -e VI_SERVER="10.133.250.201" \
                    -e VI_USERNAME=${VI_USERNAME} \
                    -e VI_PASSWORD=${VI_PASSWORD} \
                    -e VI_VM=SputnikMaik \
                    -v ${WORKSPACE}/:/scripts \
                    --security-opt label=disable \
                    vmware/powerclicore -File /scripts/NewVM.ps1
                  """
                }
            }
        }       
    }
}
