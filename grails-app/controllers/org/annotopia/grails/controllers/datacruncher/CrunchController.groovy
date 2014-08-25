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
package org.annotopia.grails.controllers.datacruncher

import grails.converters.JSON

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject


/**
 * @author Paolo Ciccarese <paolo.ciccarese@gmail.com>
 */
class CrunchController {
	
	def userAuthenticationService;
	def openAnnotationReportingService;
	
	def pulse = {
		render(view: "pulse-one", model: [menu: 'pulse'])
	}
	
	def stats = {
		render(view: "stats-one", model: [menu: 'stats'])
	}
	
	def getNumberOfAnnotations = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		render openAnnotationReportingService.countAnnotations(userId);
	}
	
	def getNumberOfAnnotationSets = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		render openAnnotationReportingService.countAnnotationSets(userId);
	}
	
	def getNumberOfAnnotatedResources = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		render openAnnotationReportingService.countAnnotatedResources(userId);
	}
	
	def getNumberOfAnnotationByResource = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForAllResources(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("resource", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationSetsByResource = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForAllResources(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("resource", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByUser = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsForEachUser(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("user", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByType = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsByType(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("type", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByClient = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsByClient(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("client", key);
			result.put("counter", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByTargetType = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsByTargetType(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("label",key);
			result.put("value", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
	
	def getNumberOfAnnotationByTargetScope = {
		def userId = userAuthenticationService.getUserId(request.getRemoteAddr());
		
		JSONArray results = new JSONArray();
		Map<String, Integer> map = openAnnotationReportingService.countAnnotationsByTargetScope(userId);
		map.keySet().each { key ->
			JSONObject result = new JSONObject();
			result.put("label",key);
			result.put("value", map.get(key).toString());
			results.add(result);
		}
		render results as JSON;
	}
}
