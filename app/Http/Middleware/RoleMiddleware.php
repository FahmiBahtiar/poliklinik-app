<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
public function handle(Request $request, Closure $next, $roles): Response
    {
        
        $user = Auth::user();

        if($user->role !== $roles){
            abort(403, 'Unauthorized action.');
        }
        return $next($request);
    }
}
