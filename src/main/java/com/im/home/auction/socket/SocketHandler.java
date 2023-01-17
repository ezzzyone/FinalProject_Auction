package com.im.home.auction.socket;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SocketHandler extends TextWebSocketHandler{
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	//참여자 목록
	private List<String> participants = new ArrayList<String>();
	//입찰 내역
	private Map<String, Long> biddingMap = new HashMap<>();
	// 입찰 횟수
	private int count = 0;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		
		sessionList.add(session);
		
		participants.add(session.getPrincipal().getName());
		
		biddingMap.put(session.getPrincipal().getName(),0L);
		
		String users = String.join(":", participants);
		
		users = "[전체참여자]:"+users;
		
		
		for(WebSocketSession s : sessionList) {
			
			s.sendMessage(new TextMessage(users));
		}
		
		
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		
		String payload = message.getPayload();
		log.info("페이로드 : {}", payload);
		
		String [] payloads = payload.split(":");
		
		// 입찰 시 biddingList 변수에 저장		
		if(payloads[0].equals("현재가")) {
			biddingMap.replace(payloads[2], Long.parseLong(payloads[3]));
			count++;
		}else if(payloads[0].equals("[퇴장]")) {
			Long lastPrice = biddingMap.get(payloads[1]);
			biddingMap.remove(payloads[1]);
			if(lastPrice == Long.parseLong(payloads[3])) {
				// 퇴장한 사람의 입찰금액이 현재가와 같으면
				if(count > 1) {
					Comparator<Entry<String, Long>> comparator = new Comparator<Map.Entry<String,Long>>() {
						
						@Override
						public int compare(Entry<String, Long> o1, Entry<String, Long> o2) {
							// TODO Auto-generated method stub
							return o1.getValue().compareTo(o2.getValue());
						}
					};
					
					//Long max = biddingMap.values().isEmpty()? 0L : Collections.max(biddingMap.values());
					
					Entry<String, Long> maxEntry = Collections.max(biddingMap.entrySet(), comparator);
					
					for(WebSocketSession s : sessionList) {
						s.sendMessage(new TextMessage("[재조정]:"+maxEntry.getKey()+":"+maxEntry.getValue()));
					}
				}else {
					for(WebSocketSession s : sessionList) {
						s.sendMessage(new TextMessage("[재조정]:"+"[초기화]"));
					}
				}
			}
		}
		
		for(WebSocketSession s : sessionList) {
			
			s.sendMessage(message);
			
		}
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		
		for(int i = 0; i<participants.size(); i++) {
			if(participants.get(i).equals(session.getPrincipal().getName())) {
				participants.remove(i);
			}		
		}
		
		String users = String.join(":", participants);
		
		users = "[전체참여자]:"+users;
		
		
		for(WebSocketSession s : sessionList) {
			
			s.sendMessage(new TextMessage(users));
		}
		
		sessionList.remove(session);
	}
	
	
	
}
