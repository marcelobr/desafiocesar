package br.org.cesar.service;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import br.org.cesar.bean.GeoCodes;
import br.org.cesar.bean.StateTweets;
import br.org.cesar.factory.ConfigurationBuilderFactory;
import twitter4j.GeoLocation;
import twitter4j.Query;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class TweetsBrazilianStateService {

	private static Twitter twitter;
	
	public TweetsBrazilianStateService() throws IOException {
		super();
		ConfigurationBuilder cb = ConfigurationBuilderFactory.getConfigurationBuilder();
		TwitterFactory tf = new TwitterFactory(cb.build());
		twitter = tf.getInstance();
	}

	public String getNumberTweetsPerBrazilianState(String hashtag) throws IOException {
		List<StateTweets> tweetsList = new ArrayList<StateTweets>();
		String arrayListToJson = null;
		try {
			// Get file from resources folder
			ClassLoader classLoader = getClass().getClassLoader();
			
			// Loads the latitude, longitude, and radius coordinates of each Brazilian state into an array
			Gson gsonGeoCode = new Gson();
			GeoCodes[] arr = gsonGeoCode.fromJson(new FileReader(classLoader.getResource("geocode.json").getFile()),
					GeoCodes[].class);
			
			// Makes a request for the twitter API for each Brazilian state
			for (GeoCodes item : arr) {
				GeoLocation geo = new GeoLocation(item.getLatitude(), item.getLongitude());
				Query query = new Query("#" + hashtag).geoCode(geo, item.getRaio(), "km");
				// Get the last 1000 tweets
				query.count(1000);
				
				Integer qty = twitter.search(query).getTweets().size();
				
				System.out.println(qty);

				StateTweets tweetItem = new StateTweets(item.getState(), qty);

				tweetsList.add(tweetItem);
			}
			
			// Creates a json with the number of tweets per brazilian state
			Gson gsonTweetsList = new GsonBuilder().create();
			arrayListToJson = gsonTweetsList.toJson(tweetsList);
		}
		catch (TwitterException te) {
			System.out.println("Failed to search tweets: " + te.getMessage());
			arrayListToJson = "Error fetching number of tweets per Brazilian state";
		}

		return arrayListToJson;
	}

}
