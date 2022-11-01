pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                git url: 'https://github.com/timovandenabbeel/csharp-ch-9-exercise-1.git', branch: 'solution-2022-2023'
                sh 'ls -al $WORKSPACE'
                sh 'bash $WORKSPACE/build.sh' 
            }
        }
    }
}
