package com.aon.lib.json;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.querydsl.core.types.dsl.StringPath;

public class JsonQPathSerializer extends JsonSerializer<StringPath>{


	@Override
	public  Class<StringPath> handledType() {
		System.out.println("call");
		return StringPath.class;
	}

	@Override
	public void serialize(StringPath value, JsonGenerator gen, SerializerProvider serializers)
			throws IOException, JsonProcessingException {
		   gen.writeStartObject();
	        gen.writeString("111");
	        gen.writeEndObject();		
	}

}
