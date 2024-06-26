
@SuppressWarnings('UnnecessaryCollectCall')
List<String> notifyMicrosoftTeams(Map params = [:]) {
   
    String color = params.color
    String status = params.status

 
    // Convert the color to a hex color if needed
    String hexColor = lookupHexColor(color: color)

   
  String result
        try {
            office365ConnectorSend(webhookUrl: params.webhookUrls, message: params.message, status: status, color: hexColor)
           result = "Success"
        } catch (err) {
          echo "Not good"
          result = "Failure"
            String message = 'Encountered an error while trying to send an ms teams notification to the '
            message += "webhook ${webook} with the message ${params.message}"
            throw new Exception(message, err)
        }

    return result
}

String lookupHexColor(Map params = [:]) {
  
    // Check to be sure that a hex color was not passed in. If it was, just return the passed in value
    def hexRegex = /^#?[a-fA-F0-9]{6}$/
    if (params.color ==~ hexRegex) {
   
        return params.color
    }

    String result = 'FFFFFF'
    switch (params.color.toLowerCase()) {
        case 'red': result = 'FF0000'; break
        case 'green': result = '00FF00'; break
        case 'blue': result = '0000FF'; break
        case 'yellow': result = 'FFFF00'; break
        case 'gray': result = 'D3D3D3'; break
        default: result = 'FFFFFF'
    }
    return result
}

