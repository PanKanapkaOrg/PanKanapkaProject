import React from "react";
import { Route } from "react-router-dom";
import Login from "../containers/Login/Login";


export default ({ component: Component, props: cProps, ...rest }) => {
    if(cProps.isAuthenticated) {
        return (<Route {...rest} render={props => <Component {...props} {...cProps} />} /> );
    }
    else {
        return (<Route {...rest} render={props => <Login {...props} {...cProps} />} /> );
    }
}