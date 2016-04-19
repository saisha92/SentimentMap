import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterException;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.conf.ConfigurationBuilder;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSAsyncClient;
import com.amazonaws.services.sqs.AmazonSQSClient;
import com.amazonaws.services.sqs.model.CreateQueueRequest;
import com.amazonaws.services.sqs.model.MessageAttributeValue;
import com.amazonaws.services.sqs.model.SendMessageRequest;

public class Get {
	
    final static int max = 100000;
    static int count = 0;
    public static void main(String[] args) throws TwitterException {
    	AWSCredentials credentials =new BasicAWSCredentials("",""); 
    	
    	AmazonSQS sqs= new AmazonSQSClient(credentials);
		 Region usEast1 = Region.getRegion(Regions.US_EAST_1);
		 sqs.setRegion(usEast1);
    	
     System.out.println("Creating SQS Now-debug");
    		 CreateQueueRequest createQueueRequest = new CreateQueueRequest("TweetQueue1");
    		String  tweetQueueUrl = sqs.createQueue(createQueueRequest).getQueueUrl();
    	
    	 ConfigurationBuilder cb = new ConfigurationBuilder();
         cb.setDebugEnabled(true)
           .setOAuthConsumerKey("")
           .setOAuthConsumerSecret("")
           .setOAuthAccessToken("")
           .setOAuthAccessTokenSecret("");
         try{
        final TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
     
    	final Connection conn = DBConnection.createConnection();
        StatusListener listener = new StatusListener() {
            @Override
            public void onStatus(Status status) {
                System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
            	if(count<max)
            	{ 
					if(status.getId()!=0 && status.getGeoLocation()!=null&&status.getLang().equalsIgnoreCase("en"))
					{
	            		System.out.println("Tweet" + status.getUser().getScreenName() + " - " + status.getText());
	            		PreparedStatement preparedStatement = null;
	            		try {
							preparedStatement = conn.prepareStatement("insert into twitter values(?,?,?,?,?)");
							preparedStatement.setString(1, Long.toString(status.getId()));
							preparedStatement.setString(2,status.getUser().getScreenName() );
							preparedStatement.setDouble(4, status.getGeoLocation().getLatitude());
							preparedStatement.setDouble(5, status.getGeoLocation().getLongitude());
							preparedStatement.setString(3, status.getText());
							preparedStatement.executeUpdate();
							Map<String, MessageAttributeValue> messageAttributes = new HashMap<>();
							messageAttributes.put("latitude", new MessageAttributeValue().withDataType("Number.latitude").withStringValue(String.valueOf(status.getGeoLocation().getLatitude())));
							messageAttributes.put("longtitude", new MessageAttributeValue().withDataType("Number.longtitude").withStringValue(String.valueOf(status.getGeoLocation().getLongitude())));
							messageAttributes.put("Text", new MessageAttributeValue().withDataType("String.Name").withStringValue(status.getText()));	
							SendMessageRequest request1 = new SendMessageRequest();
							request1.withMessageBody(status.getUser().getScreenName());
							request1.withQueueUrl(tweetQueueUrl);
							request1.withMessageAttributes(messageAttributes);
							sqs.sendMessage(request1);
							System.out.println("\nAdded to queue");
							
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
	            		count++;
					}
            	}
					else{
	            		twitterStream.removeListener(this);
	    				twitterStream.shutdown();	
						
	            	}
            	
            
            
            }

            @Override
            public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
             //   System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
            }

            @Override
            public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
               // System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
            }

            @Override
            public void onScrubGeo(long userId, long upToStatusId) {
                //System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
            }

            @Override
            public void onStallWarning(StallWarning warning) {
                //System.out.println("Got stall warning:" + warning);
            }

            @Override
            public void onException(Exception ex) {
                ex.printStackTrace();
            }
        };
        twitterStream.addListener(listener);
        twitterStream.sample();
     }
     catch(Exception e)
     {
    	System.out.println(e); 
     }
        
    }
}
