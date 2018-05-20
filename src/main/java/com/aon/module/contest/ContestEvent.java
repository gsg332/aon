package com.aon.module.contest;

import com.aon.lib.event.Event;

/**
 * @author ranian
 * 정보거래 event class
 */
@SuppressWarnings("serial")
public class ContestEvent {

	public static class Create extends Event{

		public Create(Object source) {
			super(source);
		}
	}
	
	public static class Delete extends Event{

		public Delete(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 기간만료 이벤트
	 */
	public static class Expire extends Event{

		public Expire(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 답변 등록 시 이벤트
	 */
	public static class RegistedAnswer extends Event{

		public RegistedAnswer(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 채택 완료 시 이벤트 (질문 작성자)
	 */
	public static class CompleteChoose extends Event{

		public CompleteChoose(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 추가 질문 등록 시 이벤트
	 */
	public static class AdditionalQuestion extends Event{

		public AdditionalQuestion(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 추가 답변 등록 시 이벤트
	 */
	public static class AdditionalAnswer extends Event{

		public AdditionalAnswer(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 답변 채택 시 이벤트
	 */
	public static class Choose extends Event{

		public Choose(Object source) {
			super(source);
		}
	}
	
	/**
	 * @author ranian
	 * 채택 완료 시 이벤트 (답변 등록자)
	 */
	public static class PointByChoosed extends Event{

		public PointByChoosed(Object source) {
			super(source);
		}
	}
}
