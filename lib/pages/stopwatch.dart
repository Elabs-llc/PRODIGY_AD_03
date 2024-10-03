import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  // Declare variable needed
  int seconds = 0, minutes = 0, hours = 0; // to store hours, minutes, seconds
  String digitSeconds = "00",
      digitMinutes = "00",
      digitHours =
          "00"; // to store hours, minutes, seconds string value and display them on screen
  Timer? timer; // timer class for controlling the timer
  bool isStarted = false; // to check if the timer is started
  List laps = []; // to store laps of the timer

  // stop timer function
  void stopTimer() {
    timer?.cancel();
    setState(() {
      isStarted = false;
    });
  }

  // reset timer function
  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      laps = [];
    });
  }

  // adding laps
  void addLap() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  // start timer function
  void startTimer() {
    isStarted = true;
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2757),
        title: const Text("Stop Watch"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "$digitHours:$digitMinutes:$digitSeconds",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 68.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 400.0,
              decoration: BoxDecoration(
                  color: const Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0)),
              child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Lap => ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          Text(
                            "${laps[index]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 28.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!isStarted) ? startTimer() : stopTimer();
                    },
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white)),
                    child: Text(
                      (!isStarted) ? "Start" : "Pause",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => addLap(),
                  icon: const Icon(Icons.lock_clock_rounded),
                  color: Colors.white,
                  tooltip: "Laps",
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () => resetTimer(),
                    fillColor: Colors.blue,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue)),
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
