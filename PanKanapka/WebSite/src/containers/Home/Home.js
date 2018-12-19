import React, { Component } from "react";
import "./Home.css";

export default class Home extends Component {
    render() {
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