import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.CreateTopicRequest;
import com.amazonaws.services.sns.model.CreateTopicResult;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClient;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;


public class Executor {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AWSCredentials credentials =new BasicAWSCredentials("",""); 
		String sqsurl = null;
		AmazonSQS sqs= new AmazonSQSClient(credentials);
		AmazonSNSClient snsservice = new AmazonSNSClient(credentials); //create SNS service
		CreateTopicRequest createReq = new CreateTopicRequest().withName("tweetsns");
		CreateTopicResult createRes = snsservice.createTopic(createReq);
		for (String queueUrl : sqs.listQueues().getQueueUrls()) {
			if(queueUrl.contains("TweetQueue1"))
		    {
		    sqsurl = queueUrl; 
		    }
		    }
		ReceiveMessageRequest receiveMessageRequest = 
			    new ReceiveMessageRequest();             
			receiveMessageRequest.setQueueUrl(sqsurl);
try{
		ExecutorService executor = Executors.newFixedThreadPool(10) ;
		while(true)
		{
			Runnable worker = new CopyOfSNSChecking(sqs,receiveMessageRequest,createReq,createRes);
			executor.execute(worker);
		}
}
catch(Exception e)
{
	
}
	}

}
