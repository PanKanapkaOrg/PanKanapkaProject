import React, { Component } from "react";
import "./Home.css";
import {Redirect} from "react-router-dom"

export default class Home extends Component {
    render() {
        return <Redirect to='/plans' />
        return (
            <div className="Home">
                <div className="lander">
                    <h1>Witaj w serwisie kateringowym</h1>
                    <p>Zaloguj się aby przejść do panelu managera</p>
                </div>
            </div>
        );
    }
}