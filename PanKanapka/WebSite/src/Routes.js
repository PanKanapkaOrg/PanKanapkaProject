import React from "react";
import { Route, Switch } from "react-router-dom";
import Home from "./containers/Home/Home";
import NotFound from "./containers/NotFound";
import Login from "./containers/Login/Login";
import Plans from "./containers/Plans/Plans";
import Firm from "./containers/Firm/Firm";
import AppliedRoute from "./components/AppliedRoute";
import AuthenticatedRoute from "./components/AuthenticatedRoute";

export default ({ childProps }) =>
  <Switch>
    <AppliedRoute path="/" exact component={Home} props={childProps} />
    <AppliedRoute path="/login" exact component={Login} props={childProps} />
    <AuthenticatedRoute path="/firm" exact component={Firm} props={childProps} />
    <AuthenticatedRoute path="/plans" exact component={Plans} props={childProps} />
    <Route component={NotFound} />
  </Switch>;