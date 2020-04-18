using Azure;
using System;
using System.Globalization;
using Azure.AI.TextAnalytics;

public class AzureZoom
{
    private static readonly AzureKeyCredential credentials = new AzureKeyCredential("64734ee082bf42a9abff82815d309d9f");
    private static readonly Uri endpoint = new Uri("https://westcentralus.api.cognitive.microsoft.com/text/analytics");
    private var client;
    private ZoomInstance zoomController;
    public AzureZoom(ZoomInstance zoomController)
    {
        this.client = new TextAnalyticsClient(endpoint, credentials);
        this.zoomController = zoomController;
    }

    /*This method will automatically be called every time a chat message is sent in Zoom*/
    //todo: Everytime a new chat message is sent, check how toxic it is, if it's too toxic,
    //call the methods using the ZoomInstance interface (class will be implemented later)
    //to remove the message, ban the user, or whatever else you want to do.
    //https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-sentiment-analysis?tabs=version-3
    public void newMessage(string message, int messageID)
    {
        DocumentSentiment documentSentiment = this.client.AnalyzeSentiment(message);
        var sentence = documentSentiment.senteces[0];
        if (sentence.ConfidenceScores.Negative == 1.00)
        {
            this.zoomController.deleteMessage(messageID);
        }
    }
}