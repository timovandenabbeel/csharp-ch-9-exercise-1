node('appserver001') {
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