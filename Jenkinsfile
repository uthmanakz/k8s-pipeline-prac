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
                            ssh -o StrictHostKeyChecking=no ec2-user@$KUBECTL "
                            mkdir ~/.kube && chmod 600 ~/.kube"
                            scp -o StrictHostKeyChecking=no $KUBECONFIG ec2-user@$KUBECTL:~/.kube/config
                            '''
                        }
                    }
                }
            }
        }
    }
}