package com.aon.module.contest;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface ContestMessageConfig {
	public static final String REGISTED_ANSWER = "com.aon.module.contest.ContestMessageConfig.registedAnswerMessage";
	public static final String EXPIRED = "com.aon.module.contest.ContestMessageConfig.expiredMessage";
	public static final String COMPLETE_CHOOSE = "com.aon.module.contest.ContestMessageConfig.completeChooseMessage";
	public static final String ADDITIONAL_QUESTION = "com.aon.module.contest.ContestMessageConfig.additionalQuestionMessage";
	public static final String ADDITIONAL_ANSWER = "com.aon.module.contest.ContestMessageConfig.additionalAnswerMessage";
	public static final String CHOOSE = "com.aon.module.contest.ContestMessageConfig.chooseMessage";
	public static final String POINT_CHOOSED = "com.aon.module.contest.ContestMessageConfig.pointByChoosedMessage";
	
	@ConfigKey("registedAnswerMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getRegistedAnswerMessage();
	
	@ConfigKey("expiredMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getExpiredMessage();
	
	@ConfigKey("completeChooseMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getCompleteChooseMessage();
	
	@ConfigKey("additionalQuestionMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getAdditionalQuestionMessage();
	
	@ConfigKey("additionalAnswerMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getAdditionalAnswerMessage();
	
	@ConfigKey("chooseMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getChooseMessage();
	
	@ConfigKey("pointByChoosedMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getPointByChoosedMessage();
}
