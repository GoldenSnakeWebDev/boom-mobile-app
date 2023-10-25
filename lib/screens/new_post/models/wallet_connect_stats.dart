import 'package:intl/intl.dart';

class SessionStatistics {
  DateTime? connectTime;
  DateTime? deleteTime;
  int messageTxCount = 0;
  int messageTxBytes = 0;
  int messageRxCount = 0;
  int messageRxBytes = 0;
  int errorCount = 0;
  int pingTxCount = 0;
  int pingRxCount = 0;
  int expireCount = 0;
  int extendCount = 0;

  SessionStatistics();

  @override
  String toString() {
    DateFormat dateFormat = DateFormat(DateFormat.HOUR24_MINUTE_SECOND);

    String result =
        'messageCount: $messageTxCount ($messageTxBytes bytes), errorCount $errorCount, pings(TX/RX): $pingTxCount/$pingRxCount, expireCount: $expireCount, extendCount: $extendCount';

    if (connectTime != null) {
      result +=
          ', connectTime: ${dateFormat.format(connectTime ?? DateTime.now())}';
    } else {
      result += ', connectTime: unkonwn';
    }

    if (deleteTime != null) {
      result +=
          ', deleteTime: ${dateFormat.format(deleteTime ?? DateTime.now())}';
    } else {
      result += ', deleteTime: unkonwn';
    }
    return result;
  }
}

class WalletConnectServiceStats {
  int relayPairingPingTxCount = 0;
  int relayPairingPingRxCount = 0;
  int relayClientMessageTxCount = 0;
  int relayClientMessageRxCount = 0;
  int relayClientMessageTxBytes = 0;
  int relayClientMessageRxBytes = 0;
  int relayClientTxErrorCount = 0;
  int relayClientRxErrorCount = 0;
  int relayClientReconnectCount = 0;
  DateTime? relayClientConnectTime;

  Map<String, SessionStatistics> sessionStatsMap = {};

  clearCounters() {
    relayPairingPingTxCount = 0;
    relayPairingPingRxCount = 0;
    relayClientMessageTxCount = 0;
    relayClientMessageRxCount = 0;
    relayClientMessageTxBytes = 0;
    relayClientMessageRxBytes = 0;
    relayClientTxErrorCount = 0;
    relayClientRxErrorCount = 0;
    relayClientReconnectCount = 0;
  }

  setSessionConnected(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.connectTime = DateTime.now();
  }

  setSessionDeleted(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.deleteTime = DateTime.now();
  }

  incrementPingTXCount(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.pingTxCount++;
  }

  incrementPingRXCount(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.pingRxCount++;
  }

  incrementSessionExpireCount(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.expireCount++;
  }

  incrementSessionExtendCount(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.extendCount++;
  }

  incrementSessionErrorCount(String topic) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.errorCount++;
  }

  incrementSessionMessageTxCount(String topic, int bytes) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.messageTxCount++;
  }

  incrementSessionMessageRxCount(String topic, int bytes) {
    if (!sessionStatsMap.containsKey(topic)) {
      sessionStatsMap[topic] = SessionStatistics();
    }
    sessionStatsMap[topic]?.messageRxCount++;
  }

  @override
  String toString() {
    String result = '';
    sessionStatsMap.forEach((key, value) {
      result += 'Sign Client session topic: $key: $value\n';
    });
    return (result.isEmpty) ? 'No Data' : result;
  }
}
