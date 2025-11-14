Convert the below HTML/CSS code into React component. Do not include the global components as these already exist:

<div class="min-h-screen bg-gray-50 pb-24">
  <!-- Header -->
  <div id="header-mobile" class="bg-white px-6 pt-11 pb-4">
    <div class="flex items-center justify-between">
      <h1 class="text-3xl font-bold text-gray-900">Операции</h1>
      <button class="w-10 h-10 flex items-center justify-center">
        <i class="fa-solid fa-bars text-2xl text-gray-900"></i>
      </button>
    </div>
  </div>

  <!-- Main Content -->
  <div id="main-content" class="px-6 py-6">
    <!-- Date Section -->
    <div class="mb-6">
      <h2 class="text-xl font-semibold text-gray-900 mb-4">9 ноября</h2>
      
      <!-- Empty State -->
      <div class="flex flex-col items-center justify-center py-20">
        <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mb-6">
          <i class="fa-solid fa-clock-rotate-left text-4xl text-gray-300"></i>
        </div>
        <h3 class="text-lg font-semibold text-gray-900 mb-2">Нет операций</h3>
        <p class="text-gray-500 text-center px-8">История ваших транзакций появится здесь</p>
      </div>
    </div>
  </div>

  <!-- Bottom Tab Bar -->
  <div id="tab-bar" class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 pb-6 pt-2">
    <div class="flex items-center justify-between max-w-md mx-auto">
      <a href="#" class="flex flex-col items-center justify-center w-16 py-2">
        <i class="fa-solid fa-house text-xl text-gray-400 mb-1"></i>
        <span class="text-xs text-gray-500">Главная</span>
      </a>
      <a href="#" class="flex flex-col items-center justify-center w-16 py-2">
        <i class="fa-solid fa-wallet text-xl text-gray-400 mb-1"></i>
        <span class="text-xs text-gray-500">Платежи</span>
      </a>
      <a href="#" class="flex flex-col items-center justify-center w-16 py-2">
        <i class="fa-solid fa-qrcode text-xl text-gray-400 mb-1"></i>
        <span class="text-xs text-gray-500">QR</span>
      </a>
      <a href="#" class="flex flex-col items-center justify-center w-16 py-2">
        <i class="fa-solid fa-clock text-xl text-gray-900 mb-1"></i>
        <span class="text-xs text-gray-900 font-semibold">История</span>
      </a>
      <a href="#" class="flex flex-col items-center justify-center w-16 py-2">
        <i class="fa-solid fa-user text-xl text-gray-400 mb-1"></i>
        <span class="text-xs text-gray-500">Профиль</span>
      </a>
    </div>
  </div>
</div>