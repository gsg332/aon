<%!
private static com.aon.lib.app.AppConfig appConfig =
	(com.aon.lib.app.AppConfig)
		com.aon.sys.conf.ConfigService.getConfig(
				com.aon.lib.app.AppConfig.class);


private static boolean useAnalytics()
{
	return appConfig.useAnalytics();
}

%>