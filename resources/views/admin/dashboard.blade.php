<x-layouts.app title="Admin Dashboard">
    <h1>Welcome to the Admin Dashboard</h1>
    <p>Here you can manage your application settings and users.</p>
</x-layouts.app>

<form method="POST" action="/logout">
@csrf
    <button>Logout</button>
</form>