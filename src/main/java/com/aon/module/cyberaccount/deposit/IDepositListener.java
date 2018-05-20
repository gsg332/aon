package com.aon.module.cyberaccount.deposit;

import org.springframework.context.event.EventListener;

public interface IDepositListener {

	@EventListener
	public void confirm(DepositEvent.Confirm e) throws Exception;

}
