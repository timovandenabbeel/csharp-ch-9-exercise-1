def labels = ['local', 'cloud'] // labels for Jenkins node types we will build on
def builders = [:]
for (machine in labels) {
    def label = machine // Need to bind the label variable before the closure - can't do 'for (label in labels)'

    // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
    builders[label] = {
      node(label) {
        stage('Preparation') {
            catchError(buildResult: 'SUCCESS') {
                sh 'docker stop SportStoreWebApp'
                sh 'docker rm SportStoreWebApp'
            }
        }

        stage('Build') {
            build 'BuildApp'
        }
        
        stage('Deploy') {
            sh 'docker run -t -d -p 80:80 -p 443:443 --network mssql_default -e Kestrel\\_\\_Certificates\\_\\_Default\\_\\_Path=/etc/ssl/sportstore/sportstore.pfx -e Kestrel\\_\\_Certificates\\_\\_Default\\_\\_Password=Password -e "ASPNETCORE_URLS=https://+;http://+" -v /etc/ssl/sportstore:/etc/ssl/sportstore --name SportStoreWebApp webapp 2> ~/SportStoreLog.log'
        }
      }
    }
}

parallel builders
