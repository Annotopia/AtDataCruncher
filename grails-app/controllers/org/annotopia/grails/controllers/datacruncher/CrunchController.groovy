package org.annotopia.grails.controllers.datacruncher

import grails.converters.JSON

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

/*
 * Copyright 2014 Massachusetts General Hospital
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
class CrunchController {
	
	def openAnnotationReportingService;
	
	def pulse = {
		render(view: "pulse-dc", model: [menu: 'pulse'])
	}
	
	def pulse2 = {
		render(view: "pulse-d3", model: [menu: 'pulse'])
	}
	
	def getNumberOfAnnotations = {
		render openAnnotationReportingService.countAnnotations("yolo");
	}
	
	def getNumberOfAnnotationSets = {
		render openAnnotationReportingService.countAnnotationSets("yolo");
	}
	
	def getNumberOfAnnotatedResources = {
		render openAnnotationReportingService.countAnnotatedResources("yolo");
	}
	
	def getNumberOfAnnotationByResource = {
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForAllResources("yolo");
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("resource", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationSetsByResource = {
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForAllResources("yolo");
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("resource", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByUser = {
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForEachUser("yolo");
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("user", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByClient = {
		
	}
	
	def getNumberOfAnnotationByType = {
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsByType("yolo");
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("type", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
}
