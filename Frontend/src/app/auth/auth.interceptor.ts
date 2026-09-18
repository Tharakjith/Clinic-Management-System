import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor() {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {


    console.log("I am intercepting....");

    //if login ,no need to check jwt
    if(request.url.includes('api/logins')){
      console.log("Not checking JWT");
    }
    else{
      //Existing token
      let token =localStorage.getItem('JWT Token');
      // checking access role and jwt token
      if(localStorage.getItem('AccessRole')&&(localStorage.getItem('JWT Token')))
      {
        //if jwt is there -- send next.handle
        const newRequest = request.clone(
          {
            setHeaders:
            {
              AuthoriZation: `Bearer ${token}`  // ` symbol
            }
          }
        );
        return next.handle(newRequest);
      }
    }
    return next.handle(request);
  }
}
