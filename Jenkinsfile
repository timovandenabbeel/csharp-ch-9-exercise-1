pipeline {
    agent any
    
    stages {
        stage('init') {
            steps {
                step([$class: 'WsCleanup'])
                git url: 'https://github.com/timovandenabbeel/csharp-ch-9-exercise-1.git', branch: 'solution-2022-2023'
            }
        }
        stage('Build') {
            steps {
                sh 'bash $WORKSPACE/build.sh' 
            }
        }
    }
}
