import { Injectable } from '@angular/core';
import { map, Observable, Observer } from 'rxjs';
import { AnonymousSubject, Subject } from 'rxjs/internal/Subject';
import { environment } from 'src/environments/environment';

const SOCKET_URL = environment.websocket_endpoint;


@Injectable({
  providedIn: 'root',
})
export class SocketService {
    private subject: any;
    public messages: Subject<any>;

    constructor() {
        this.messages = <Subject<any>>this.connect(SOCKET_URL).pipe(
            map(
                (response: MessageEvent): any => {
                    let data = JSON.parse(response.data)
                    return data;
                }
            )
        );
    }

    public connect(url: string): AnonymousSubject<MessageEvent> {
        if (!this.subject) {
            this.subject = this.create(url);
        }
        return this.subject;
    }

    private create(url: string): AnonymousSubject<MessageEvent> {
        let ws = new WebSocket(url);
        let observable = new Observable((obs: Observer<MessageEvent>) => {
            ws.onmessage = obs.next.bind(obs);
            ws.onerror = obs.error.bind(obs);
            ws.onclose = obs.complete.bind(obs);
            return ws.close.bind(ws);
        });
        let observer = {
            error: (error: ErrorEvent) => null,
            complete: () => null,
            next: (data: Object) => {
                if (ws.readyState === WebSocket.OPEN) {
                    ws.send(JSON.stringify(data));
                }
            }
        };
        return new AnonymousSubject<MessageEvent>(observer, observable);
    }
}
