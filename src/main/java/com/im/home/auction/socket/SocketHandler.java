package com.im.home.auction.socket;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SocketHandler extends TextWebSocketHandler{
	
	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		for(WebSocketSession webSocketSession : sessions) {
			if(webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) {
				webSocketSession.sendMessage(message);
			}
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		sessions.add(session);
	}
}
