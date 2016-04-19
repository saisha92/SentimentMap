
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.util.*;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.CreateTopicRequest;
import com.amazonaws.services.sns.model.CreateTopicResult;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.SubscribeRequest;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClient;
import com.amazonaws.services.sqs.model.CreateQueueRequest;
import com.amazonaws.services.sqs.model.DeleteMessageRequest;
import com.amazonaws.services.sqs.model.GetQueueUrlResult;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.MessageAttributeValue;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;


public class SNSChecking implements Runnable {
private AmazonSQS sqs;
private ReceiveMessageRequest receiveMessageRequest;
private CreateTopicRequest createReq;
private CreateTopicResult createRes;
//private AmazonSNSClient snsservice;
	public CopyOfSNSChecking(AmazonSQS sqs,ReceiveMessageRequest receiveMessageRequest,CreateTopicRequest createReq,CreateTopicResult createRes)//AmazonSNSClient snsservice
{
	this.sqs = sqs;
	this.receiveMessageRequest = receiveMessageRequest;
	this.createReq = createReq;
	this.createRes = createRes;
	//this.snsservice=snsservice;
	
}
	@Override
	public void run() {
		String tweetText = null;
		String Latitude = null;
		String Longtitude = null;
		String Sentiment = null;
		String Text = null;
		
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		AWSCredentials credentials =new BasicAWSCredentials("","");
		AmazonSNSClient snsservice = new AmazonSNSClient(credentials); //create SNS service
		CreateTopicRequest createReq = new CreateTopicRequest().withName("tweetsns");
		CreateTopicResult createRes = snsservice.createTopic(createReq);
        List<Message> messages = sqs.receiveMessage(receiveMessageRequest.withMessageAttributeNames("All")).getMessages();
        for (Message message : messages) {
            System.out.println("    Body:          " + message.getBody());
          //System.out.println(  message.getMessageAttributes());
            
            //message.getAttributes().entrySet();
            for (Entry<String, MessageAttributeValue> entry : message.getMessageAttributes().entrySet()) {
                
                if(entry.getKey().toString().equalsIgnoreCase("Text"))
                		{
                	tweetText = entry.getValue().getStringValue();
                		}
                if(entry.getKey().toString().equalsIgnoreCase("latitude"))
        		{
        	Latitude = entry.getValue().getStringValue();
        		}
                if(entry.getKey().toString().equalsIgnoreCase("longtitude"))
        		{
        	Longtitude = entry.getValue().getStringValue();
        		}
                
                //System.out.println("    Name:  " + entry.getKey().toString());
                //System.out.println("    Value: " + entry.getValue().getStringValue());
            }
            tweetText=tweetText.replaceAll("\\s+", "%20");
    	    try{
    		URL url = new URL("http://access.alchemyapi.com/calls/text/TextGetTextSentiment?apikey=bde9fa4d82dadee5e144b70a52f67d0929c9037d&text="+tweetText);
    		URLConnection connection = url.openConnection();
    		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    		DocumentBuilder builder = factory.newDocumentBuilder();
    		Document doc = builder.parse(connection.getInputStream());
    		TransformerFactory factory1 = TransformerFactory.newInstance();
    		Transformer xform = factory1.newTransformer();
    		xform.transform(new DOMSource(doc), new StreamResult(System.out));
    		NodeList nList = doc.getElementsByTagName("docSentiment");
    		for (int temp = 0; temp < nList.getLength(); temp++) {
    			Node nNode = nList.item(temp);
    			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
    				Element eElement = (Element) nNode;
    				System.out.println("\nSentiment : " + eElement.getElementsByTagName("type").item(0).getTextContent());
    			Sentiment = eElement.getElementsByTagName("type").item(0).getTextContent();
    			}
    		}
    	    }
    	    catch(Exception e)
    	    {
    	    	
    	    }
    	    PublishRequest publishReq = new PublishRequest().withTopicArn(createRes.getTopicArn()).withMessage(Latitude +","+Longtitude+","+Sentiment+","+tweetText);
            snsservice.publish(publishReq);
            System.out.println("Deleting a message.\n");
        
        }
		
	}
	
            
		
	}


