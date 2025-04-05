pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials ('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
    }

    stages{
        stage ('Terraform init') {
            steps {
                sh'''
                terraform init
                '''
            }
        }

        stage('Terraform plan') {
            steps {
                sh '''
                terraform plan
                '''
            }
        }

        stage('Terraform apply') {
            steps{
                sh'''
                terraform apply -auto-approve
                '''
            }
        }

        stage ('SSH into kubectl remote') {
            steps {
                script { 
                    withCredentials([file(credentialsId : 'KUBECONFIG-FILE' , variable : 'KUBECONFIG')]) {
                        sshagent(credentials : ['SSH_PRIVATE_KEY'] ) {
                            sh '''
                            KUBECTL=$(terraform output | grep KUBECTL | awk -F '"' '{print $2}') 
                            ssh -o StrictHostKeyChecking=no ec2-user@$KUBECTL ' mkdir -p ~/.kube/ && touch ~/.kube/config && chmod 600 ~/.kube/config '
                            scp -o StrictHostKeyChecking=no $KUBECONFIG ec2-user@$KUBECTL:~/.kube/config
                            '''
                        }
                    }
                }
            }
        }
        stage ('Downloading kubectl') {
            steps{
                script{
                    sshagent(credentials : ['SSH_PRIVATE_KEY']) {
                        sh'''
                        KUBECTL=$(terraform output | grep KUBECTL | awk -F '"' '{print $2}')
                        ssh -o StrictHostKeyChecking=no ec2-user@$KUBECTL '
                        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&
                        chmod +x kubectl &&
                        mkdir -p ~/.local/bin &&
                        mv ./kubectl ~/.local/bin/kubectl '
                        '''

                    }
                }
            }
        }

        stage('Applying pods/services') {
            steps {
                sshagent (credentials : ['SSH_PRIVATE_KEY'] ) {
                    sh'''
                    KUBECTL=$(terraform output | grep KUBECTL | awk -F '"' '{print $2}')
                    scp -o StrictHostKeyChecking=no *.yml ec2-user@$KUBECTL:/home/ec2-user/
                    ssh -o StrictHostKeyChecking=no ec2-user@$KUBECTL "
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} ;
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} ;
                    export AWS_DEFAULT_REGION=eu-west-2 ;
                    kubectl apply -f . " 
                    '''
                }
            }
        }

    }
}