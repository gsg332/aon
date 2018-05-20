package com.aon.lib.json;

import java.io.IOException;
import java.util.Properties;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class PropertiesSerializer extends JsonSerializer<Properties>{

	@Override
	public Class<Properties> handledType() {
		 return Properties.class;
	}

	@Override
	public void serialize(Properties prop, JsonGenerator gen, SerializerProvider serializers)
			throws IOException, JsonProcessingException {
		  	gen.writeStartArray();
		  	for(Object key : prop.keySet() ){
		  		gen.writeStartObject();
		        gen.writeStringField("key", key.toString()); 
		        gen.writeStringField("value", prop.getProperty(key.toString()));
		        gen.writeEndObject();
		  	}
	        gen.writeEndArray();
	}

}
