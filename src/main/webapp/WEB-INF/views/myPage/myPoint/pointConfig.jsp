<%!
private static com.aon.module.cyberaccount.point.PointConfig pointConfig =
	(com.aon.module.cyberaccount.point.PointConfig)
		com.aon.sys.conf.ConfigService.getConfig(
				com.aon.module.cyberaccount.point.PointConfig.class);

private static int getRatioDollarToPoint()
{
	return pointConfig.getRatioDollarToPoint();
}

private static double getFees()
{
	double fees = pointConfig.getFeesPercent() / (double)100;
	return fees;
}

private static int getFeesPercent()
{
	return pointConfig.getFeesPercent();
}
%>