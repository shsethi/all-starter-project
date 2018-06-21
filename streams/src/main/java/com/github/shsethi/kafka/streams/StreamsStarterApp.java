package com.github.shsethi.kafka.streams;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.Produced;

import java.util.Arrays;
import java.util.Properties;

/**
 * The type Streams starter app.
 */
public class StreamsStarterApp {

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {

        Properties config = new Properties();
        config.put(StreamsConfig.APPLICATION_ID_CONFIG, "fav-color");
        config.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        config.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        config.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());

        config.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, "0");

        StreamsBuilder builder = new StreamsBuilder();

        KStream<String, String> kStream = builder.stream("favourite-colour-input");
        // do stuff

//        KTable<String, Long> wordCount =
//                 kStream.mapValues(value -> value.toLowerCase())
//                        .flatMapValues(value -> Arrays.asList(value.split(" ")))
//                        .selectKey((k, v) -> v)
//                        .groupByKey()
//                        .count();


//        KTable<String, Long> colorCount =
        KStream<String, String> userColors = kStream.selectKey((k, v) -> v.split(",")[0])
                .mapValues(value -> value.split(",")[0].toLowerCase())
                .filter((user, color) -> Arrays.asList("blue", "green", "red").contains(color));

        userColors.to("user-keys-and-colours", Produced.with(Serdes.String(), Serdes.String()));


        KTable<String, String> kStream2 = builder.table("user-keys-and-colours");
        KTable<String, Long> colorCount = kStream2
                                                    .groupBy( (key, value) -> new KeyValue<>(value,value) )
                                                    .count();

        colorCount.toStream()
                .to("favourite-colour-output", Produced.with(Serdes.String(), Serdes.Long()));

        KafkaStreams streams = new KafkaStreams(builder.build(), config);
        streams.cleanUp(); // only do this in dev - not in prod
        streams.start();

        // print the topology
        System.out.println(streams.localThreadsMetadata());

        // shutdown hook to correctly close the streams application
        Runtime.getRuntime().addShutdownHook(new Thread(streams::close));

    }

}
