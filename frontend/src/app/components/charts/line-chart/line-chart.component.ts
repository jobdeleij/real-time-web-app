import { Component, OnDestroy, OnInit } from '@angular/core';
import Chart from 'chart.js/auto'
import zoomPlugin from 'chartjs-plugin-zoom';
import { Subscription } from 'rxjs';
import { SocketService } from 'src/app/services/socket.service';

Chart.register(zoomPlugin);

@Component({
  selector: 'app-line-chart',
  templateUrl: './line-chart.component.html',
  styleUrls: ['./line-chart.component.scss']
})
export class LineChartComponent implements OnInit, OnDestroy {

  chart: any;
  keep_going: boolean = false;
  subscriber: Subscription;


  constructor(private _websocketService: SocketService) {
    this.subscriber = _websocketService.messages.subscribe(data => {
      data = JSON.parse(data)
      console.log(data);
      this.chart.data.datasets[0].data = data.map((item: { temp: any; }) => item.temp).reverse();
      this.chart.data.datasets[1].data = data.map((item: { windSpeed: any; }) => item.windSpeed).reverse();
      this.chart.data.labels = data.map((item: { ts: any; }) => new Date(item.ts['$date']).toLocaleTimeString('NL-nl')).reverse();
      this.chart.update('none');
      setTimeout(() => {
        if(this.keep_going) {
          this.getData();
        }
      }, 1000);
    });
  }
  ngOnDestroy(): void {
    this.subscriber.unsubscribe();
  }

  toggleKeepGoing() {
    this.keep_going = !this.keep_going;
    if (this.keep_going) {
      this.getData();
    }
  }

  getData() {
    this._websocketService.messages.next({'sensorId': 123});
  }

  ngOnInit(){
    this.chart = new Chart('canvas', {
      type: 'line',
      options: {
        plugins: {
          zoom: {
            pan: {
              enabled: true,
              mode: 'xy'
            },
            zoom: {
              wheel: {
                enabled: true,
              },
              pinch: {
                enabled: true
              },
              mode: 'x',
            }
          }
        },
        responsive: true,
        elements: {
          point:{
              radius: 0
          }
        },
        scales: {
          x: {
            ticks: {
              autoSkip: true,
              maxTicksLimit: 20
            }
          },
        }
      },
      data: {
        labels: [],
        datasets: [
          {
            type: 'line',
            label: 'Temperature',
            data: [],
            borderColor: '#3F3FBF',
            backgroundColor: '#3F3FBF',
            fill: false
          },
          {
            type: 'line',
            label: 'Wind speed',
            data: [],
            borderColor: '#01244d',
            backgroundColor: '#01244d',
            fill: false
          }
        ]
      }
    });
  }
}
