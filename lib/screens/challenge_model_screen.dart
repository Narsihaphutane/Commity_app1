// ─── challenge_model.dart ─────────────────────────────────────────────────────

class Challenge {
  final int id;
  final String emoji;
  final String title;
  final String category;
  final String badge; // 'HOT' | 'NEW' | 'POPULAR' | ''
  final String description;
  final List<String> suitable;
  final String mode; // 'Online' | 'Offline'
  final String validity; // e.g. '5 days'
  final int participants;
  final int progressPercent;
  final String duration;
  final String difficulty;
  final List<String> tags;
  final List<String> steps;
  final String reward;

  const Challenge({
    required this.id,
    required this.emoji,
    required this.title,
    required this.category,
    required this.badge,
    required this.description,
    required this.suitable,
    required this.mode,
    required this.validity,
    required this.participants,
    required this.progressPercent,
    required this.duration,
    required this.difficulty,
    required this.tags,
    required this.steps,
    required this.reward,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────
final List<Challenge> allChallenges = [
  Challenge(
    id: 0,
    emoji: '🏋️',
    title: '30-Day Weight Loss Transformation',
    category: 'fitness',
    badge: 'HOT',
    description:
        'A full-body program to help you lose weight, build muscle, and develop lasting healthy habits over 30 days.',
    suitable: ['Kids', 'Women', 'Men'],
    mode: 'Online',
    validity: '5 days',
    participants: 12430,
    progressPercent: 68,
    duration: '30 days',
    difficulty: 'Moderate',
    tags: [
      'Weight Loss',
      'Beginner Friendly',
      'Daily Workouts',
      'Nutrition Plan',
    ],
    steps: [
      'Sign up and complete your fitness profile',
      'Receive your personalized 30-day workout plan',
      'Log your daily activity and meals',
      'Join weekly live coaching sessions',
      'Complete the final assessment and earn your badge',
    ],
    reward: '🏅 Weight Warrior Badge + Certificate',
  ),
  Challenge(
    id: 1,
    emoji: '🏃',
    title: '5K to 10K Running Challenge',
    category: 'running',
    badge: 'NEW',
    description:
        'Train progressively to double your running distance in just 6 weeks with guided plans and GPS tracking.',
    suitable: ['Adults', 'Teens'],
    mode: 'Offline',
    validity: '3 days',
    participants: 8210,
    progressPercent: 45,
    duration: '6 weeks',
    difficulty: 'Intermediate',
    tags: ['Running', 'Cardio', 'Outdoors', 'Personal Best'],
    steps: [
      'Download the training app and set your goal',
      'Follow the 3-day-per-week running schedule',
      'Track your pace and distance via GPS',
      'Join local running groups in your city',
      'Complete your first 10K run and upload proof',
    ],
    reward: '🥇 10K Finisher Medal + Digital Trophy',
  ),
  Challenge(
    id: 2,
    emoji: '✍️',
    title: '30-Day Writing Challenge',
    category: 'writing',
    badge: 'POPULAR',
    description:
        'Write every single day for 30 days. Build your creative muscle, find your voice, and publish your anthology.',
    suitable: ['All Ages'],
    mode: 'Online',
    validity: '7 days',
    participants: 21500,
    progressPercent: 82,
    duration: '30 days',
    difficulty: 'Easy',
    tags: ['Writing', 'Creativity', 'Daily Habit', 'Community'],
    steps: [
      'Join the writing community on the platform',
      'Receive daily writing prompts at 7 AM',
      'Submit your 200-word minimum entry',
      'Give feedback to 2 other writers',
      'Publish your 30-day anthology',
    ],
    reward: '📖 Published Author Badge + Community Feature',
  ),
  Challenge(
    id: 3,
    emoji: '🧘',
    title: '21-Day Mindfulness & Meditation',
    category: 'mindfulness',
    badge: 'NEW',
    description:
        'Reduce stress, improve sleep, and build mental resilience with guided daily 10-minute meditation sessions.',
    suitable: ['Kids', 'Women', 'Men', 'Seniors'],
    mode: 'Online',
    validity: '10 days',
    participants: 5670,
    progressPercent: 30,
    duration: '21 days',
    difficulty: 'Easy',
    tags: ['Mindfulness', 'Stress Relief', 'Sleep', 'Mental Health'],
    steps: [
      'Set your intention and download guided audio',
      'Complete 10-minute morning meditation daily',
      'Journal your mood before and after each session',
      'Attend 2 live group meditation sessions',
      'Share your transformation story with the community',
    ],
    reward: '🧠 Zen Master Badge + Wellness Report',
  ),
  Challenge(
    id: 4,
    emoji: '🥗',
    title: '14-Day Clean Eating Reset',
    category: 'health',
    badge: 'HOT',
    description:
        'Reset your diet, cut out processed foods, and discover delicious whole food recipes in just 2 weeks.',
    suitable: ['Women', 'Adults'],
    mode: 'Online',
    validity: '2 days',
    participants: 9320,
    progressPercent: 55,
    duration: '14 days',
    difficulty: 'Moderate',
    tags: ['Nutrition', 'Clean Eating', 'Recipes', 'Gut Health'],
    steps: [
      'Remove processed foods from your pantry',
      'Follow the provided 14-day meal plan',
      'Cook and photograph 3 meals per week',
      'Log energy and mood changes daily',
      'Complete the final health check-in',
    ],
    reward: '🥦 Clean Eater Badge + Cookbook PDF',
  ),
  Challenge(
    id: 5,
    emoji: '❤️',
    title: 'Heart Health 28-Day Program',
    category: 'health',
    badge: '',
    description:
        'Improve cardiovascular health with daily cardio, healthy eating, and stress management techniques.',
    suitable: ['Adults', 'Seniors'],
    mode: 'Online',
    validity: '4 days',
    participants: 3890,
    progressPercent: 20,
    duration: '28 days',
    difficulty: 'Moderate',
    tags: ['Heart Health', 'Cardio', 'Lifestyle', 'Doctor Approved'],
    steps: [
      'Get a baseline heart rate and BP reading',
      'Follow the daily cardio routine (20–40 min)',
      'Track food and sodium intake',
      'Complete weekly virtual health check-ins',
      'Get final health score improvement report',
    ],
    reward: '💓 Heart Hero Badge + Health Analysis',
  ),
];

// ─── Filter & Sort Constants ──────────────────────────────────────────────────
const List<Map<String, String>> filterCategories = [
  {'id': 'all', 'label': 'All', 'icon': '🌟'},
  {'id': 'fitness', 'label': 'Fitness', 'icon': '💪'},
  {'id': 'health', 'label': 'Health', 'icon': '❤️'},
  {'id': 'running', 'label': 'Running', 'icon': '🏃'},
  {'id': 'writing', 'label': 'Writing', 'icon': '✍️'},
  {'id': 'mindfulness', 'label': 'Mindfulness', 'icon': '🧘'},
];

const List<Map<String, String>> sortOptions = [
  {'id': 'popular', 'label': '🔥 Popular'},
  {'id': 'newest', 'label': '✨ Newest'},
  {'id': 'deadline', 'label': '⏳ Deadline'},
  {'id': 'easy', 'label': '⚡ Easy'},
];
