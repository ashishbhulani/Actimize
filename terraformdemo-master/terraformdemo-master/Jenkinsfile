pipeline {
agent any
stages {
stage('Provision infrastructure') {
 steps {
   bat 'C://Terraform//terraform init'
   bat 'C://Terraform//terraform plan -out=plan'

 }
}
  stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }
stage('TF Apply') {
      steps {
        
          bat 'C://Terraform//terraform apply plan'
        
      }
    }
}
}
 
