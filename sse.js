var es = new EventSource("ServerSide.ashx");
var stat;

es.onerror = function (e) {
	switch (e.target.readyState) {
		case EventSource.CONNECTING:
			stat = "等待重新連線";
			break;
		case EventSource.CLOSED:
			stat = "連線失敗，停止連線";
			break;
	}
	document.getElementById("divMsg").innerHTML += stat + "<br/>";
}

es.onmessage = function (e) {
	document.getElementById("divMsg").innerHTML += "現在時刻：" + e.data.toString() + "<br/>";
}

es.onopen = function (e) {
	switch (e.target.readyState)
	{
		case EventSource.CONNECTING:
			stat = "Connecting";
			break;
		case EventSource.OPEN:
			stat = "Open";
			break;
		case EventSource.CLOSED:
			stat = "Closed";
			break;
		default:
			stat = "n/a";
			break;
	}
	document.getElementById("divMsg").innerHTML += "連線狀態：" + stat + "<br/>"
}
