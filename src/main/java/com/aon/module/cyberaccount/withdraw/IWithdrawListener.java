package com.aon.module.cyberaccount.withdraw;

import org.springframework.context.event.EventListener;

public interface IWithdrawListener {
	
	@EventListener
	public void Confirm(WithdrawEvent.Confirm e) throws Exception;

}
